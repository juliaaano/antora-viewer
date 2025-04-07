# Antora Viewer

This is a simple container to generate Antora asciidoc content and serve it with a webserver.

The purpose of this container is to be used as a development tool for Antora projects.

## Build and run with Podman.

```
cd container/
podman build -t localhost/antora-viewer .
```

In your Antora website directory, run the following.

```
podman run --rm --name antora -v $PWD:/antora -p 8080:8080 -i -t localhost/antora-viewer
```

To specify an alternate Antora configuration file, set the `ANTORA_CONFIG` environment when starting the container using the `-e` parameter with the location of the file.
