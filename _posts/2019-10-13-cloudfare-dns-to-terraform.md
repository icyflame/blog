---
layout: post
comments: true
title: Managing DNS (or any other infrastructure) using Terraform
categories: dns cloudflare terraform
---

**Note:** This post ended up being a lot longer than I expected it to be! It's a
post about why Terraform is great, even for setups where configurations don't
change often and how you can use it to share the access that you have with other
people without giving them access to the actual infrastructure account. I will
make a separate post about the specifics of importing DNS records from
Cloudflare into Terraform and the process I used for that. 

Terraform is great! It is a way to manage your infrastructure using a set of
version-controlled text files with a `plan` command that tells you what is going
to change and an `apply` command that applies the changes that the `plan` told
you about.

Where terraform gets really good is when you store the Terraform State file in a
GCS bucket and run the `plan` and `apply` commands in your repository's CI.

<!--more-->

It's a loot of hoopla for DNS management of a personal domain. Is it worth it?
Well, that depends on whether you have the time and motivation to set it up.
Once you set it up though, it's INCREDIBLY convenient.

## What?

Terraform has three concepts that are pretty useful to know about:

- **Terraform state:** This is the part of your infrastructure that has been
"imported" into Terraform. Terraform manages the state of these "resources". If
you change any of these resoures from the web GUI and not through terraform,
terraform has no idea about the changes you made and the `plan` will start
getting weird.
- **Terraform configuration files:** These are the files with the actual
resources. Each resource has a type and an identifier inside terraform. And it
has some arguments and attributes. Arguments are configurable and can be changed
through these files. Attributes are read-only and generally include things like
a generated ID which is used by the infrastructure provider to keep track of
your resource.
- **Terraform providers:** Providers are plugin-type software packages which
form the interface between Terraform and the infrastructure provider. As far as
I understand, Terraform understands the 3 changes that can be done on any given
resource: `create`, `update` and `delete`. 
    - During `plan`
        - Terraform calls the provider and gives it the changes that were made
        to the terraform configuration files
        - The provider then calls the API of the infrastructure provider to find
        out what changed
        - The provider gives terraform the changes
    - During `apply`
        - Terraform calls the provider and tells it the resources to `create`,
        `update` and `delete`
        - The provider calls the API of the infrastructure provider and makes
        the appropriate `POST`, `PUT` and `DELETE`/`POST` requests
        - The provider returns to terraform the actual changes made
- **Terraform backend:** A backend is the location where the state file is
stored. By default, this is `local`. You store and manage the state file
yourself. You can also set this up to be in a cloud storage option like Digital
Ocean Spaces or Google Cloud Storage. Storing the state file in the cloud allows
you to give others access to run `plan` and `apply` commands.

So, in this manner, terraform has completed abstracted out the actual
infrastructure being managed from the provider that it is provided by.
Everything is a resource in the terraform world, and there can be only three
operations to a resource: `create`, `update` or `delete`.

## How useful is it?

Now, just having a log of all the changes you have made to your DNS records is
pretty useful. You can go back and forth in time, you will never really have to
deal with IPs again because of how easy it would be to create a new record, and
so on.

The other features that terraform brings to the table are:

- An audit log that can be seen by _anyone_ with access to the repository
- Collaborators who can add records without having access to the actual
infrastructure provider account

Both the first and second are extremely useful for DNS management. I use
Cloudfare as the DNS provider for my personal domain, and cloudfare has this
annoying way of changing DNS credentials from one account to another account.
You have to export the DNS records, import it into the new account and then
change the NS records at the domain provider.

I tried to do that once for metakgp.org (another domain that my account is
        connected to) and it _did not_ go well. Something went wrong, the
transfer didn't work and the website was down for about 12 hours. This wasn't
very catastrophic, it's a college project and it went down at a time when very
few people were trying to access the domain. Nevertheless, the whole point of
that was to ensure that the DNS was being managed by someone who was in the
college instead of someone who had graduated.

The thing about colleges is that people keep graduating! And few people in their
freshman or sophomore year have any clue about what DNS is or what records are
or how to change them safely etc. I learnt most of the things I know about DNS
in my fourth year at college. So, this would be a perennial problem.

So, the basic thing that I was looking for from a move to terraform was a way to
safely share access to the infrastructure provider with other people.

## A completely local setup

Now, you can have a bunch of terraform configuration files in a repository
alongwith the state file. You can run appropriate `terraform plan` and
`terraform apply` commands manually. The state file is a file that has to be
maintained separately from the configuration files.

One way to do it that's fairly manual and works for use-cases where changes are
not very common and are centralized with a few people is to keep the state file
checked into Git. The state file is a JSON file and can be easily stored and
versioned. The local flow would look something like this:

- You import your DNS records into the local configuration files + the state
files
- You put this repository out there
- People make a pull request with the changes they want to make
    - You run `terraform plan` manually and post the output on the PR
- You (and others) review their PR; you merge it when they look okay
- Now, you (or anyone who has access) manually run `terraform apply` and apply
the changes that were requested

This is already a great improvement on the nightmarish process of moving DNS
management from account to account just to let others take over access. You have
to remain involved in the process, yes, but at least others can review and all
you have to do is run the `plan` and `apply` commands.

## What if you use Continuous Integration?

Continuous Integration (CI) makes this whole process incredibly easy. It
de-centralizes DNS management without de-centralizing control over the provider
account. Here's the flow with CI:

- You import your DNS records into a terraform state and into local
configuration files
- You set-up Google Cloud Storage (GCS) to act as the backend for your terraform
state
    - Now, your state file is stored on GCS instead of being stored locally on
    your computer!
    - Anyone with the right credentials can run the `plan` and `apply` commands
    now!
- You set-up a CI pipeline where opening a pull-request runs the `plan` command
and merging to `master` runs the `apply` command
    - You have to give the CI pipeline access to the provider and the GCS bucket
    using a service account
    - Both these things are fairly easy to accomplish
- Now, you let others make Pull Requests
    - When someone makes a pull-request, they can go to the CI pipeline and see
    the `plan`
    - If the `plan` looks okay, they can request review
    - Others review the PR and approve it if everything looks good
    - Anyone with permissions to `merge` to `master` can merge the PR and have
    the changes show up in their infrastructure right away!
        - Note that the person who is merging doesn't need to have access to the
        GCS bucket OR to the infrastructure provider! All they need to have
        access to is the repository that is maintaining the configuration.

_This_ is the holy grail. A single repository on which users can be added and
removed as required. 

- If changes you didn't want to merge have been merged to master, you can revert
the PR and merge to master again. VOILA!
- If something goes wrong, you can lock down access 
- If you fear that the CI keys have been taken by a bad actor, you can remove
that actor and roll them


## Conclusion

- Terraform lets you share the ability to make changes to your infrastructure with
a wide group of people without giving them any direct access to the
infrastructure itself.
- Terraform lets you maintain an audit log of the changes that happened to your
infrastructure
- Terraform lets you roll-back unwanted changes with a simple revert PR
