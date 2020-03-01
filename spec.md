# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - * *Used Sinatra to build my app* *
- [x] Use ActiveRecord for storing information in a database - * *Used ActiveRecord for storing information in db* *
- [x] Include more than one model class (e.g. User, Post, Category) - Included 4 model classes: User, Dependent, Activity, UserActivity* *
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - * *Dependent has_many :activities, Dependent has_many :activities* *
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) - * *Dependent belongs_to :user, Activity belongs_to :dependent* *
- [x] Include user accounts with unique login attribute (username or email) - * * User has email attribute* *
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - * * Dependnt has CRUD routes, Activity has CRUD routes* *
- [x] Ensure that users can't modify content created by other users - * *Users can only edit their own dependents and activities* *
- [x] Include user input validations - * *User model includes email uniqueness validation, Dependent model includes name presence validation, Activity includes title presence validation* *
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - * *Used flash to display errors in views* *
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code - * *README.md includes a short description, install instructions, a contributors guide and a link to the license for your code* *

Confirm
- [x] You have a large number of small Git commits - * *98 commits and counting- yikes!* *
- [x] Your commit messages are meaningful - * *I need practice on this* *
- [x] You made the changes in a commit that relate to the commit message - * *For the most part, I believe* *
- [x] You don't include changes in a commit that aren't related to the commit message - * *I need to work on making more specific commits in the future, but for the most part they should be ok* *
