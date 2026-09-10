# Notes to self

Welcome to the source code and material for my [website](https://dpb-hydro.github.io/). Below are some notes for myself for development.

## Local hosting

Set installation location to local folder:

```bash
bundle config set --local path 'vendor/bundle'
```

To set up site environment:

```bash
bundle install
```

To run locally:

```bash
bundle exec jekyll serve
```

## Adding images to posts

Basic image:

```
{% include figure image_path="/assets/images/cyprus-workshop.png" alt="Cyprus workshop fieldwork" %}
```

Image with caption

```
{% include figure image_path="/assets/images/cyprus-workshop.png" alt="Cyprus workshop fieldwork" caption="Field measurements during the Cyprus workshop." %}
```

Image with controlled width

```
{% include figure image_path="/assets/images/cyprus-workshop.png" alt="Cyprus workshop fieldwork" caption="Smaller version of the image." width="350" %}
```
