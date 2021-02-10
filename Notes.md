beneficial## Ruby views

```erb
<%= embedded ruby %>
<% %>
```


## Inheritance In Ruby:

```ruby
class ClassName < ParentClassName
end
```


## Routes

Routes are configured in the `config/routes.rb` file

```rb
Rails.application.routes.draw do
  root 'pages#home' # Rails auto adds _controller to the end of this string
  # adding a #hello means that rails is expecting a 'hello' method inside the application_controller
  get 'test', to: 'application#hello'
  get 'about', to: 'pages#about'
  resources :entries
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
```

### Define a route that points to a `controller#action`

Have an appropriately named controller and action that describe the page being rendered
  - controller for static pages `pages_controller.rb`
  - action for homepage: 'def home'
  - If done this way Rails will expect a new folder in the 'views' folder named after the controller and an `.html.erb` file named after the action that exists within the controller.


We can generate controllers using the `rails` command line
 - `rails generate controller name_of_controller`
    - generates the `controller.rb` file and views folder for that controller

## Directory Structure of a Ruby on Rails Project
`app/assets`
  - images and stylesheets go here that we want to use in our pages
  - Also where configs live

`application.html.erb` >> root html page for rendering. (where header tags live)
`app/controllers` >> where all the controllers will live
 - `ApplicationController`: all other controllers we create will inherit this controller so it will house the default functionality

`app/helpers` >> where helper functions for view templates live
`app/javascript/packs/application.js` >> the main JS manifest file that makes JS available throughout the app
`app/models` >> database models, all the models we will create will extend the `application_record.rb` class
`app/views/layouts` >> where all the view templates live
`bin/` >> mostly ignore
`config/` >> where the app config files live, live env configs
`Gemfile` >> dependencies for the rails application
 - `bundle install` will install the dependencies and create the `Gemfile.lock`
 which describes the version numbers and dependencies of all your dependencies


### Deploying Rails Applications to Production

`git push heroku` <- pushes code to heroku and builds the website
`heroku login` <- login to heroku in cli


### Generate all the necessary files for a new object

```shell
rails generate scaffold NameOfResource column:string column:text
```

Creates the:
- controllers
- views
- models
- routes
- test units
- helpers
- static assets
- and migrations


***This command is not really used in the fife project since its a mess***


```rb
resources :model_name
```
Gives us actions related to database models


```
> rails routes --expanded
will print all the routes for your application

> rails generate migration name_of_migration
This will generate a migration and time stamp it

> rails db:migrate
runs the rails migration files that are outstanding
The details of what the migrations made are contained in the /db/schema.sql file

> rails db:rollback
reverts the last migration file that was run
```

###### Example of a basic Migration file

```rb
def change
  add_column :name_of_tables, :created_at, :datetime
  add_column :name_of_tables, :updated_at, :datetime
end
```
**The create_at and updated_at columns are magic columns that are managed by rails**

## Naming conventions in Ruby on Rails

**Model name**: article

**Class name**: Article -> Capitalized A and singular, CamelCase

**File name**: `article.rb` -> singular and all lowercase, snake_case

**Table name**: articles -> plural of model name and all lowercase

### Minimal Model Example
```rb
class ModelName < ApplicationRecord
end
```
Models can communicate automatically with the database
Automatically inherits getters and setters to make and edit records

```
> rails console (or rails c) <- starts the rails console
```
You can test the connetion between the a Model and the database by typing the
name of the Model and .all
 - ModelName.all

### CRUD Operations in the Rails Console:
```
> ModelName.create(column1: "value")
```
- as long as you see the "commit transaction" message, the record was created

> Easily create new records by assigning the model to a new variable
```shell
>> model = ModelName.new
>> model.column1 = "this is a value"
```

To see the values stored in the model you just type the variable name in the console.

```shell
> model.save
```

This will save model to a new record using the data we set and set the variable to the returned row value (this will set created_at/updated_at values)

```shell
> exit
# Will pull you out of the rails console
```




##### More Examples of Rails console operations with models
```shell
  > Article.create(title: "first article", description: "Description of first article") # make sure Article is capitalized if using this method
  > article = Article.new
  > article.title = "second article"
  > article.description = "description of second article"
  > article.save
  > article = Article.new(title: "third article", description: "description of third article")
  > article.save
```


### RUD Operations using Rails Console

To get a specific row by id
```shell
> Article.find(1)
```
Read the first Article row
```shell
> Article.first
```
Read the last Article row
```shell
> Article.last
```

Updating a rows value in the rails Console
```shell
> article = Article.find(1)
> article.title = "Edited Title"
> article.save
```

Deleting a row in the Rails Console
```shell
> article = Article.last
> article.destroy
---- or ----
> Article.last.destroy
```


Enforcing Validation on database table using models
```rb
class Article < ApplicationRecord
  validates :title, presence: true
  validates :column_name, validation_rule: value, validation_rule2: value
  validates :column_name, length: {minimum: 3, maximum: 100}
end
```

If you try and save an Article now that does not have a title it will not save to the database
```shell
> article = Article.new
> article.save
=> false
> article.errors
=> Will return the ActiveModel::Errors Object
> article.errors.full_messages
=> Human readable error messages of why the Article didn\'t save
```

```shell
> reload!
```
Makes sure that your rails console has the latest changes in your code


## Adding New Models to routes.rb

```rb
resources :modelname, only: [:show]
```
- using the `only` keyword you can specify what routes you want to expose
  to the public
    - default options include [:show, :]
- There needs to be a corresponding controller for the Model named ModelNameController
- The new controller needs to have a corresponding action/function for each route you are exposing
- Each Controller action/function needs a view folder, template for the corresponding actions/function

To render specific records from a table you need an action that will use
the corresponding model to query the Database
```rb
def show
  @article = Article.find(params[:id])
end
```

`params` is the hash of all the parameters passed from the browser
Now within the view we can access the article with the given ID passed in through the url
@ in-front of a variable makes it an instance variable which is what makes it available inside the view

```html
<h1>Single Article View</h1>
<p><strong>Title:</strong> <%= @article.title =></p>
<p><strong>Descripotion:</strong> <%= @article.description =></p>

```

> Adding `byebug` to rails code will pause execution and open the ruby console
> typing `continue` into the console will resume execution


### Show List of Database Records using Models and routes

```rb
class ArticleController < ApplicationController
  def index
    @articles = Article.all
  end
end
```

```html
<h1>Articles Listing Page</h1>
<table>
  <thead>
    <tr>Title</tr>
    <tr>Description</tr>
  </thead>
  <tbody>
    <% @articles.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= article.description %></td>
    </tr>
    <% end %>
  </tbody>
</table>
```


### Ruby on Rails Forms

- There needs to be a new and create actions for the controller we are adding a form to
- Ruby on Rails gives us special form tools to be able to build forms that create new entries into our Database
- The `form_with` new helper is the preferred helper for rails and uses **ajax** to submit the form by default
- We will be using http POST instead, to do so we will add `local: true` in the parameters for `form_with`
- `form_for` uses HTTP POST by default
- We will need to whitelist the data coming in from the form. Rails has a security feature that prevents non-whitelisted data from being passed into the controller
  - This is called "strong params"

```rb
class ArticlesController < ApplicationController
  def new
  end

  def create
    render plain: params[:article]
    # This will render the data we input into the form after submit
    @article = Article.new(params.require(:article).permit(:title, :description))
    # Rails is smart enough to extract the values of the params article hash and save them to the Article table
    # .permit() is whitelisting the title and description from the article key in the params Hash
    @article.save
    # Save the permitted data to the database
    redirect_to articles_path(@article)
    # Pass the route path, rails can extract the ID from the Article object and use that to render the page
  end
end
```

```html
<h1>Create New Article</h1>

<%= form_with scope: :article, url: articles_path, local: true do |f| %>
  <p>
    <%= f.label :title %>
    <br/>
    <%= f.text_field :title %>
  </p>
  <p>
    <%= f.label :description %>
    <br/>
    <%= f.text_area :description %>
  </p>
  <p>
    <%= f.submit %>
  </p>
<% end %>
```

### Adding Friendly Messages to the form views

- The validation will occur if the save fails.
- `.save` returns false if there are validation errors

```rb
class ArticlesController < ApplicationController
  def new
    @article = Article.new
    #ensures that when we load the page for the first time we have an Article variable
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      flash[:notice] = "Successfully created article!"
      # Flash hashes have notice and error keys
      redirect_to articles_path(@article)
    else
      render 'new'
  end
end
```

```html
<h1>Create New Article</h1>
<% if @article.errors.any? %>
  <h2>The following errors prevented the article from being saved</h2>
  <ul>
    <% @article.errors.full_messages.each do |msg| %>
      <li><%= msg %></li>
    <% end %>
  </ul>
<% end %>

<%= form_with scope: :article, url: articles_path, local: true do |f| %>
...
```

Flash messages need to be added to the root `application.html.erb` file so that they can be rendered

Minimal Example
```html
...
<body>
  <% flash.each do |name, msg| %>
    <%= msg =>
  <% end %>
</body>
...
```


### Updating Existing Article Records

Similar to the create action where we had a new and create method in the ArticlesController we will have an edit and update method to accomplish our goal.
First we need to expose the edit and update routes if we are using the only keyword in the routes file

```rb
resources :articles, only: [:show, :index, :new, :create, :edit, :update]
```
>Remember we can use the rails routes --expanded command to see the routes that are enabled in our app

Now we need to add the actions to the controller and the views tempates

```rb
class ArticlesController < ApplicationController
  ...
  def edit # GET Operation
    # initialize the Article instance variable so that errors in the view can be read
    @article = Article.find(params[:id])
  end
  def update # PATCH operation. Where the update occurs
    # First find the article we are editing
    @article = Article.find(params[:id])
    if article.update(params.require(:article).permit(:title, :description)) # Update the
      flash[:notice] = "Article was updated successfully"
      redirect_to @article # view the updated article
    else
      render 'edit' # Re-render the edit form where the errors will be displayed
    end
  end
end
```

`edit.html.erb`
> Notice this is mostly the same as the submit action form with the exception of the form_with implementation


```html

<h1>Edit Article</h1>

<%= form_with(model: @article, local: true)  do |f| %>
  <p>
    <%= f.label :title %>
    <br/>
    <%= f.text_field :title %>
  </p>
  <p>
    <%= f.label :description %>
    <br/>
    <%= f.text_area :description %>
  </p>
  <p>
    <%= f.submit %>
  </p>
<% end %>
```

Using the `form_with(model: @article)` makes it so that the url that it puts to correspond to the Article that we are editing. Doing this will also pre-fill the form with the current values of the Article based on the id.

`update.html.erb`





### Destroy Action

First we have to expose the destroy route

```rb
resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
```

Now that we have added the `:destroy` action to the whitelist, there is now no need to include a whitelist. The below will be the same as the above EXCEPT the below exposes REST-ful routes to rails resources.

```rb
resources :articles
```

> REST - Representational state transfer - mapping HTTP verbs to CRUD actions

`DELETE /articles/:id` will map to the `articles#destroy` method

```rb
class ArticlesController < ApplicationController
  ...
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
end
```

> NOTE: in the `rails routes --extended` output you can see the prefix for a controller, that is the prefix for the `_path` variable which we see used above.

Now that we've created the destroy method, we need to link to it in the view.

```html

<h1>Articles Listing Page</h1>
<table>
  <thead>
    <th>Title</th>
    <th>Description</th>
    <th colspan="3">Actions</th>
    <!-- The colspan will be important later -->

  </thead>
  <tbody>
    <% @articles.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= article.description %></td>
      <td><%= link_to 'Delete', '#' %></td>
    </tr>
    <% end %>
  </tbody>
</table>
```

link_to is how you create an "\<a\>" in embedded ruby tags.
  - the first parameter is the text for the \<a\> tag
  - the second is the path for the link

To implement the id into the path for the destroy link, we need to replace the '#' with `article_path(article)` this will now route us to the article's view page. This by default uses a GET request but we need it to make a DELETE request so to do that we just need to ad d `method: :delete` to the end of our route.

`<td><%= link_to 'Delete', article_path(article), method: :delete %></td>`

### Beautifying the articles list page


To add a 'Show' link we can use what we saw previously.

`<td><%= link_to 'Show', article_path(article) %></td>` GET request

To add an 'Edit' link we can again use what we already know

`<td><%= link_to 'Edit', edit_article_path(article) %></td>` GET request to the edit action

Now lets add a link that will take us to the form to create a new article:
`<%= link_to 'Create new Article', new_article_path %>`

It would be beneficial to add the edit and delete article link to the View Article Page and we can use the same embedded ruby tag we used above.
Also extra credit if you add a link to add a link back to the article listing page.

### Adding an additional confirmation step to deleting articles.

We can accomplish this by adding some JS
```html
<td><%= link_to 'Delete', article_path(article), method: :delete, data: { confirm: "Are you sure?"} %></td>
```
This will utilize the javascript alert box to confirm if you want to delete something.


### DRY - Don't Repeat Yourself  Code
