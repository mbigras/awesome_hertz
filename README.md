# Playing with Cloud Run and Cloud Build

Plays further with terraform-cloud-run-demo at:
https://github.com/mbigras/terraform-cloud-run-demo

Play with Google Cloud Platform with less focus on documentation and more focus on taking notes and playing/hacking.

## Demo

The demo is driven using make targets:

```
git clone https://github.com/mbigras/awesome_hertz
cd awesome_hertz
export TF_VAR_project=<YOUR PROJECT>
make deps
make init
make plan
make apply
make output
export URL=<YOUR URL>
curl $URL/foo/bar/baz
curl $URL/cat/dog/mouse
make list
make destroy
make apply
```
