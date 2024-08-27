# Blog App

Blog app have been created to create some blogs of people.
[reference link](https://www.youtube.com/watch?v=ELFORM9fmss&list=PLlzmAWV2yTgCjoZNF3hLX3puYJir9vSQO)

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/85a7ec01d8d14695a5514c64745807a3)](https://app.codacy.com/gh/B1loliddin/blog-app/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)

## Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Videos](#videos)
- [Installation](#installation)
- [Packages used](#packages-used)

## Features

- Sign in/Sign up
- Read all blogs
- Upload blog
- Get image from gallery
- Categories
- Detail page(read time)
- Internet connection checking

## Screenshots

<p style="display: flex;">
  <img src="screenshots/screenshot_sign_in_page.png" alt="Sign in" width="250"/>
  <img src="screenshots/screenshot_sign_up_page.png" alt="Sign up" width="250"/>
  <img src="screenshots/screenshot_home_page.png" alt="Home page" width="250"/>
</p>

<p style="display: flex;">
  <img src="screenshots/screenshot_create_blog_page.png" alt="Blog page" width="250"/>
  <img src="screenshots/screenshot_create_blog_page_2.png" alt="Blog page 2" width="250"/>
</p>

## Videos

[Video on YouTube](https://youtu.be/CDTkN01vKhM)

## Installation

After cloning this repository go to `blog-app` folder. Then, follow the following steps:

- Create project in [supabase](https://supabase.com)
- Create secrets folder inside core folder
- Create app_secrets.dart file in secrets folder
- Get your supabase project url and supabase anon key
- Connect your keys into your project

## Packages used

- fp_dart
- supabase_flutter
- bloc
- meta
- flutter_bloc
- dotted_border
- get_it
- image_picker
- uuid
- transparent_image
- intl
- internet_connection_checker_plus
- hive
