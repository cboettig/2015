---
layout: post
published: false

---


### Repository build


### Repository size


Repo files are 21Mb (zipped).
Most of this is in `assets/files` (31 MB, mostly large pdfs including pubs), though `_posts` is 14 Mb.
The `.git` directory on `master` branch, by comparison, is 237 Mb. 

### Compile 

------

## A more modular structure?

Perhaps the most obvious approach to the issue is to break the site over multiple repositories. 
In particular, it would be useful to separate out the older entries that do not need to be rebuilt
regularly into a more static repository. 

This raises some challenge in keeping the layout and appearance consistent without maintaining
copies of layout files across multiple repositories; and similarly in managing URLs and paths. 
By moving the domain name `www.carlboettiger.info` from the CNAME of my `labnotebook` repository
to my `cboettig.github.com` repository, that root URL will be shared across all my gh-pages repositories
unless they are given their own `CNAME` files (e.g., using subdomains). 

For each year:

- [x] create notebook repositories by year by cloning from labnotebook (to preserve git history), e.g.

```
git clone labnotebook 2014
```
and then remove the local origin to the original site:

```
cd 2014 && git remote rm origin
```

- edit `_config.yml` to remove `/:year` from `_config.yml` (the repository name will automatically be used as part of the URL)
- delete all posts from different years (preferable to just wait until deleting their history, which will remove the files as well), e.g. for 2014:

```bash
files=`echo {_posts/2008-*,_posts/2009-*,_posts/2010-*,_posts/2011-*,_posts/2012-*,_posts/2013-*}`
git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch $files" HEAD
```

If repository has already been sync'd to Github we also need:

```
git rebase origin/master
```

- [x] delete the CNAME file.

- [ ] delete all the relatively static pages files that will be hosted directly from `cboettig.github.io` (`index.html`, `research.md`, etc., but not dynamically created `tags.html` etc).  

- [ ]  adjust `repo:` in `_config.yml` to match the repository year. This will automatically fix the sha and history links in the sidebar.
- [ ] Other tweaks to the sidebar: `site.repo` liquid must be added to categories, tags, next, and previous links. 

Dynamic pages and other dynamic content in root: 

One of the biggest challenges 

- `lab-notebook.html` page becomes part of `cboettig.github.io` along
with other root pages.  Being in a different repository from the posts,
it does not have access to the post index.

		* twitter, mendeley and github feeds will still work. A cron job
			building this part of the site can see to it that this content
			is regularly updated.

		* The summary previews of entries pose more of a problem, since
			this content is now on another repository.  Perhaps update this
			via the RSS feeds from other pages?  One way or another will
			involve some restructuring of this landing page.

- [ ] Atom feeds.
- [ ] tags
- [ ] categories
- [ ] archive

The easy part of this is simply adjusts paths so that these generate
correctly within each year and link to appropriately (a matter of adding a
few `site.repo` liquid tags). The less obvious part is what to do about
these pages as they appear root repo, `cboettig.github.io`; that is, if
and how the tags, feeds, etc. should be aggregated across the different
repositories.

The archive page is the simplest, as it is natural for this to use
different pages by year. The root archive page can then merely link to
each year (though such links must added manually).

Categories and tags provide an intermediate case.  It's certainly not ideal
to have these disaggregated across year, but on the other hand this will
keep individual category and tag pages cleaner by having either fewer entries 
or fewer tags on a single page. For a crude first pass we can simply put redirects
to the current year's tags and categories in the root, and note on the category
and tag template that these are for the current year only. We can also be tricky and
update these redirects automatically based on the current date with a Jeykll
Liquid filter rather than manually update them.  Ideally we should
also link back to the other years category, tag, and archive pages.

Atom feeds are a different matter. To first approximation only the feed of
the current year's entries is really relevant; the others may be provided
for historical/archival purposes only (having all content in a contiguous 
XML file in standard format is convenient for certain use cases).  The trick
here is not break existing URLs.  The simplest thing might be to convert the base
feeds into redirects for the most recent feeds; though it's not clear how to 
do so for atom XML files (my [SO question](http://stackoverflow.com/questions/27736953)
on the subject). 




- delete the assets? (Delete their history too using (`filter-branch`) Leaving them in is necessary for local previewing at least. Most assets are now loaded from CDN, only the twitter-bootstrap must be loaded locally. Use full URL.  

[SO on rewriting git history](http://stackoverflow.com/questions/2100907/how-to-remove-delete-a-large-file-from-commit-history-in-git-repository)


- Need a trick such that the "Previous" button on the first post of the new year takes you to the index page of the previous year.



