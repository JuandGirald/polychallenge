Polymath Challenge
===================

This is a polymath callenge! 

Install
====================
Clone the repo in your local machine

    cd polychallenge 

Ebay API steup
==================
In your lib/polychallenge/yaml directory is a file called `ebay.example.yml`

Copy this file to `ebay.yml` and edit the values found there to match your Ebay credentials.

Commands
================
Run in the command line the followings:

    rake rebuild

This command download the ebay category tree from the API and create your database to store the ebay data.

    rake render[<category_id>]

This command create a html file in your root directory that contains a simple web page displaying the category tree rooted at the given ID.

If the last command doesn't work try with this:

    rake 'render[<category_id>]'

Examples
====================

    rake render[179281]
    ls 179281.html
    179281.html
    
    rake render[6666666666]
    No category with ID: 6666666666
