---
layout: single
title: "Julia cheat sheet"
date: 2026-03-26 15:22:00 +0000
last_modified_at: 2026-03-26 15:22:00 +0000
categories: computing
tags: julia cheat_sheet
---

## External cheat sheet

A useful external cheat sheet can be found at [The Fast Track to julia 1.0](https://cheatsheet.juliadocs.org/). Below are my own useful notes.

## Type hierarchy

To see types above and below

```julia
supertype()
subtypetree() # self-defined 
```

To see who exported the object:

```julia
parentmodule()
parentmodule(var"@which") # for macros
```
