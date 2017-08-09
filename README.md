# chrisgarrett/react-native-android

* Container for working with React Native on Android with a minimal install footprint

## Versions / packages
* node 8.2.1
* openjdk 8u131

## Usage

### Standalone app:

Assumes that `app` is the directory that contains your package.json.
```
docker run --rm \
      -v `pwd`/examples/links/app:/work/app \
      chrisgarrett/react-native-android:24.3.4 \
      npm start
```

### App + libraries

When the container loads any folders mouned in `/work/libs` will automatically
be linked `npm link` to your app. Again, this assumes that each subfolder
contains a package.json file. For an example see `examples/links`.

1. Start your library project first
```
docker run --rm \
      -v `pwd`/examples/links/libs/mylib1:/work/app \
      chrisgarrett/react-native-android:24.3.4 \
      npm start
```

1. Next start your application mounting your library project
```
docker run --rm \
      -v `pwd`/examples/links/app:/work/app \
      -v `pwd`/examples/links/libs/mylib1:/work/libs/mylib1 \
      chrisgarrett/react-native-android:24.3.4 \
      npm start
```

#### Docker Compose

Here is an example compose file:

```
version: '2'
services:

  app:
    container_name: links_app
    image: chrisgarrett/react-native-android:6.9.1
    command: npm start
    ports:
    - 3000:3000
    volumes:
    - ./examples/links/app:/work/app
    - ./examples/links/libs/mylib1:/work/libs/mylib1
    depends_on:
    - mylib1

  mylib1:
    container_name: links_lib1
    image: chrisgarrett/react-native-android:6.9.1
    command: npm start
    volumes:
    - ./examples/links/libs/mylib1:/work/app
```

Run with:
```
docker-compose -p links up
```



## Credits

* OpenJDK Dockerfile from https://github.com/docker-library/openjdk/blob/b4f29ba829765552239bd18f272fcdaf09eca259/8-jdk/alpine/Dockerfile
* Android Dockerfile from https://github.com/yongjhih/docker-alpine-android/blob/50cc0b4c5ac304be0435fea48caaded8abcf3183/Dockerfile
