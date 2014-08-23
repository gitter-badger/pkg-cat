#PKG.CAT
PKG.CAT is an app that lets people bundle together a collection of links,
attachments, and information about themselves to share. A great use case would
be a speaker at a conference who wants to bundle their slides, some articles,
and a bit about themselves into an email. Now with PKG.CAT anyone can share
their bundle by sharing their packages unique email address (i.e.
`speakers-package@pkg.cat`).

See directions and try it out for yourself here at
[PKG.CAT](http://www.pkg.cat)!
<img src="https://raw.githubusercontent.com/georgetmayorga/pkg-cat/master/app/assets/images/landing-page.png"
width="500">

*Built using Rails, Coffeescript, Heroku, Paperclip, AWS S3, SendGrid, Griddler, Bourbon,
Neat*

Here are some of the interesting product design features of PKG.CAT:

##Users: No sign up, no sign in
I wanted people to use the app without adding to their username and
password litter. This meant no user account sign up, and no sign in. While
making adoption of the app easier, there were trade-offs when it came to letting
non-users edit and delete the material they created. How would we know that the
visitor was the owner of the package and not someone who just went to the url?

I approached the edit/delete problem with an aim to provide reasonable security
and ease to an owner concerning manipulation of their materials. I started with
the maker of a package receiving an
email confirmation, and in it is a link to edit the package. This link leads to
a path using the packages `private_token`, a unique random 64 character string generated using the
`SecureRandom.urlsafe_base64(64)` from the Ruby standard library. This token
allows a reasonably secure way for updating and deleting without the need for
usernames and passwords. The token is safe in deterring intruders, and keeps the
knowledge private to the creators inbox.

##Email: Processing and Parsing with Griddler
Looking to make the app function mainly through email, I used a gem called
[Griddler](http://griddler.io) to help handle the incoming email and turn it
into a responsive Email Object. Griddler automatically looked for a class called
`EmailProcessor` and called the `process` method on it. You can look at mine
[here](https://github.com/georgetmayorga/pkg-cat/blob/master/app/models/email_processor.rb#L6-L12).

From here I generate a new `Package` by processing the email body in the
`EmailAdapter` [found
here](https://github.com/georgetmayorga/pkg-cat/blob/master/app/models/email_adapter.rb#L15-L20). I
 created a custom parser to iterate over the email body lines,
find the keyword and values, and save them to the database. 

Some of these values
are links, which themselves are made up of `Name` and `URL` key/value pairs. So
this parser finds the links and they are [turned into `Link`
objects](https://github.com/georgetmayorga/pkg-cat/blob/master/app/models/package_generator.rb#L9),
responding to `.name` and `.url` and saved on their own table in the database. 

Another case that needs to be taken into account are `slug` attributes. A slug
is the `your-package-name` of `your-package-name@pkg.cat`. If the
user includes this attribute when creating a package, it needs to be checked for uniqueness in the
database. If it's left blank or already taken we assign the `Package` a 6 digit
value for slug using `SecureRandom.hex(3)`. This value is checked
against the database for uniqueness as well. I decided to override the `slug=()`
method
[here](https://github.com/georgetmayorga/pkg-cat/blob/master/app/models/package.rb#L48-L55)
to keep my business logic and validation of slug in the model.

##Saving Attachments: Paperclip & S3
Incoming emails can also have attachments, this required both [Amazon
S3](http://aws.amazon.com/s3/) and the
[Paperclip](https://github.com/thoughtbot/paperclip) gem. Fortunately, Paperclip
makes [it
simple](https://github.com/georgetmayorga/pkg-cat/blob/master/app/models/package.rb#L14-L17)
adding attachments to a `Package`. Setting things up between S3 and Paperclip
is necessary when running on Heroku because of the way Heroku manages certain
account type storage. This rendered their database unreliable, and the working
with S3 necessary. Changing around the [Paperclip
configs](https://github.com/georgetmayorga/pkg-cat/blob/gm-readme/config/environments/production.rb#L14-L21) makes this possible. 

When sending out email, I needed to use ActionMailer to find the files on S3,
read them, and attach them to the corresponding email. You can see that code
[here](https://github.com/georgetmayorga/pkg-cat/blob/master/app/models/outbound_mailer.rb#L29-L33).

##Challenges
Throughout the app, I faced multiple points where trade offs needed to be
made or problems needed to be solved. Here are a some in detail.

####DRY Principle with Return Values
In the
[EmailProcessor](https://github.com/georgetmayorga/pkg-cat/blob/master/app/models/email_processor.rb#L21)
I needed to have `PackageGenerator.new(@email).generate` return a `Package`
object. Looking at where this is called
[here](https://github.com/georgetmayorga/pkg-cat/blob/master/app/models/package_generator.rb#L7-L11)
we can see creating `Link` and `Attachment` objects need `package.id` and
therefore need to be called after the `Package` is created since an `id` isn't
assigned until `.save` is called. But `update_links` and
`update_attachments` return `true` and not a `Package` object, and so the
typical pattern would be to return the `Package` object repeated on the last
line for the sole purpose of returning the correct object.

The solution I used is `.tap`. It lets you chain methods to run on the
return value of what you called `.tap` on. For us, `.create` returns a
`Package` object, and I run `.update_links` and `.update_attachments` inside
that block. Of course the most useful part is that , and I run `.update_links`
and `.update_attachments` inside that block. Of course the most useful part is
that `.tap` returns the initial object it was called on.
