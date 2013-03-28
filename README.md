Caisson
===============

Caisson provide a set of tools to facilitate the integration of Zurb-Foundation to your Rails project.

Install
-------

```
gem install caisson
```

### Rails 3

In your Gemfile:

```ruby
gem 'zurb-foundation'
gem 'caisson'
```

In your application.js

```javascript
//= require foundation
//= require caisson
```

In your application.scss
```css
@import "foundation";
```

Orbit Slider
-----

###  Basic examples

```erb
<%= orbit_slider ['apple', 'banana', 'peach'] do |fruit| %>
  <h1>I like <%= fruit %></h1>
<% end %>
```

```erb
<% images = ["img1.jpg", "img2.jpg", "img3.jpg", "img4.jpg"] %>
<%= orbit_slider images, columns_per_slide: 2 do |img| %>
  <img src="<%= img %>" />
<% end %>
```

###  Supported parameters

<table>
  <tr>
    <th>Name</th>
    <th>Default</th>
  </tr>
  <tr>
    <td>animation_speed</td>
    <td>400</td>
  </tr>
  <tr>
    <td>bullets</td>
    <td>false</td>
  </tr>
  <tr>
    <td>class</td>
    <td>slider</td>
  </tr>
  <tr>
    <td>columns_per_slide</td>
    <td>1</td>
  </tr>
  <tr>
    <td>id</td>
    <td></td>
  </tr>
  <tr>
    <td>timer_speed</td>
    <td>0</td>
  </tr>
</table>

For more details on Orbit, see [Foundation - Orbit](http://foundation.zurb.com/docs/orbit.php).

Copyright
---------

Copyright (c) 2013 De Marque inc. See LICENSE for further details.
