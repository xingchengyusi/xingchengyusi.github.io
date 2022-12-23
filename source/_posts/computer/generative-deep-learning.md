---
title: Generative Deep Learning
lang: en
date: 2022-12-17 21:36:42
tags:
- deep learning
- ai
- machine learning
- generative
- python
category:
- computer
---

# Generative Deep Learning

## Introduction to Generative Adversarial Networks (GANs) (对抗生成网络)

Combined by a forger network and an expert network.

- Generator network
    - Input: random vector (a random point at a latent space)
    - Output: synthetic image
- Discriminator Network
    - Input: image (real or synthetic)
    - Output: predict where this image comes from.

> What is a latent space?
>
> A vector space that cannot be observed.

### Difference

The GANS different forms of other training setting up, the optimization minimum is not fixed. With the GANS, every step tries to take down the hill changes the entire landscape. There exists an equilibrium balance between two processes or forces, not a minimum optimization process.

Also, in this case, GANS hard to train.

### Schematic Implement

This is a **deep convolutional GANS (DCGANs)**.

1. `generator` maps vectors `(latent_dim)` to shape of image `(32, 32, 3)`.
2. `discriminator` maps image shape `(32, 32, 3)` to a binary 'real' probability.
3. `gan` chains the generator and discriminator together. `gan(x) = discriminator(generator(x))`.
4. train the discriminator by real and fake images and labels.
5. train the generator to fool the discriminator. Move the weight of the generator that makes discriminator classify generated image as a real image.

### Tricks

1. `tanh` as the last activation in the generator.
2. sample point the latent space using a *normal distribution*.
3. Stochasticity improves robustness. GANs may be stuck in any sort of way because of the resulting balanced equilibrium.
    1. `dropout` in discriminator (and generator).
    2. adding random noise to labels of the discriminator.
4. sparse gradient hinder GANs training different from other deep learning technology. Here are two methods to decrease:
    1. change `maxpooling` to stried convolution for downsampling.
    2. change `ReLu` to `LeakyReLu` which relax sparsity constants by allowing small negative activation value.
5. To fix the checkerboard artifact caused by unequal coverage of the pixel space in the generator, the stridden `Conv2DTranpose` or `Conv2D` in both generator and discriminator.
6. When adversarial loss increases and discriminative loss tends to 0 (discriminator end up dominating the generator), reduce the discriminator learning rate, and increase the dropout level of the discriminator.

### The Generator

```python
# import
import keras
from kerasimport layers
import numpy as np

# input shape
latent_dim = 32
height = 32
width = 32
channels = 3

# module
generator_input = keras.Input(shape=(latent_dim, ))
# transform the input into a 16*16 128 channel feature map
x = layers.Dense(128 * 16 * 16)(generator_input)
x = layers.LeakyReLu()(x)
x = layers.Reshape((16 * 16 * 128)) (x)

x = layers.Conv2D(256, 5, padding='same')(x)
x = layers.LeakyReLu()(x)

# upsamples to 32*32
x = layers.Conv2DTranspose(256, 4, strides=2, padding='same')(x)
x = layers.LeakyReLu()(x)

x = layers.Conv2D(256, 5, padding='same')(x)
x = layers.LeakyReLu()(x)
x = layers.Conv2D(256, 5, padding='same')(x)
x = layers.LeakyReLu()(x)

# produces 32*32 1 channel feature map
x = layers.Conv2D(channels, 7, activation='tanh', padding='same')(x)
generator = keras.models.Model(generator_input, x)
generator.summary()
```

### The Discriminator

```python
discriminator_input = layers.Input(shape=(height, width, channels))
x = layers.Conv2D(128, 3)(discriminator_input)
x = layers.LeakyReLU()(x)
x = layers.Conv2D(128, 4, strides=2)(x)
x = layers.LeakyReLU()(x)
x = layers.Conv2D(128, 4, strides=2)(x)
x = layers.LeakyReLU()(x)
x = layers.Conv2D(128, 4, strides=2)(x)
x = layers.LeakyReLU()(x)
x = layers.Flatten()(x)

# dropout layer
x = layers.Dropout(0.4)(x)

# output layer
x = layers.Dense(1, activation='sigmoid')(x)

# instantiates module
discriminator = keras.models.Model(discriminator_input, x)
discriminator.summary()

# using gradient clipping by value in the optimizer / to stabilize, use learning rate decay
discriminator_optimizer = keras.optimizers.RMSprop(lr=0.0008, clipvalue=1.0, decay=1e-8)
discriminator.compile(optimizer=discriminator_optimizer, loss='binary_crossentropy')
```

### The GANs

```python
# only applies to gan model
discriminator.trainable = False

gan_input = keras.Input(shape=(latent_dim, ))
gan_output = discriminator(generator(gan_input))
gan = keras.models.Model(gan_input, gan_output)

gan_optimizer = keras.optimizers.RMSprop(lr=0.0004, clipvalue=1.0, decay=1e-8)
gan.compile(optimizer=gan_optimizer, loss='binary_crossentropy')
```

### How to train the DCGAN

```python
import os
from keras.preprocessing import image

# laod cifar-10
(x_train, y_train), (_, _) = keras.datasets.cifar10.load_data()

x_train = x_train.reshape(
  (x_train.shape[0],) +
  (height, width, channels)).astype('float32') / 255.

iterations = 10000
batch_size = 20
save_dir = 'your_dir'

start = 0
for step in range(iterations):
  random_latent_vectors = np.random.normal(size=(batch_size, latent_dim))

generated_images = generator.predict(random_latent_vectors)

stop = start + batch_size
real_images = x_train[start: stop]
combined_images = np.concatenate([generated_images, real_images])

labels = np.concatenate([np.ones((batch_size, 1)), np.zeros((batch_size, 1))])
labels += 0.05 * np.random.random(labels.shape)

d_loss = discriminator.train_on_batch(combined_images, labels)

random_latent_vectors = np.random.normal(size=(batch_size, latent_dim))

misleading_targets = np.zeros((batch_size, 1))

a_loss = gan.train_on_batch(random_latent_vectors, misleading_targets)

start += batch_size
if start > len(x_train) - batch_size:
  start = 0

if step % 100 == 0:
  gan.save_weights('gan.h5')

  print('discriminator loss:', d_loss)
  print('adversarial loss:', a_loss)

  img = image.array_to_img(generated_images[0] * 255., scale=False)
  img.save(os.path.join(save_dir, 'generated_frog' + str(step) + '.png'))
  img = image.array_to_img(real_images[0] * 255., scale=False)
  img.save(os.path.join(save_dir, 'real_frog' + str(step) + '.png'))
```