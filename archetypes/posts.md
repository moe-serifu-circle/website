---
title: "{{ replace .TranslationBaseName "-" " " | strings.TrimLeft " 0123456789" | title }}"
date: {{ .Date }}
draft: true
authors: ["Rebecca C. Nelson"]
tags: []
categories: ["news"]
---
