# Antora Viewer

This is a simple container to generate Antora asciidoc content and serve it with a webserver.

The purpose of this container is to be used as a development tool for Antora projects.

## Build the Container with Podman.

```
cd container/
podman build -t localhost/antora-viewer .
```

### Running the Image

The following environment variable can be utilized at runtime using the `-e` parameter:

| Variable  | Description | Default |
| --------- | ----------- | ------- |
| `ANTORA_CONFIG` | Name of the Antora configuration file (Playbook). If not set, auto-detects `site.yml` then `default-site.yml`. | Auto-detected |
| `ANTORA_USER_DATA` | Name of the file containing YAML formatted Antora attributes | `user_data.yml` |

In your Antora website directory, run the following.

```
podman run --rm --name antora -v $PWD:/antora -p 8080:8080 -i -t localhost/antora-viewer
```
