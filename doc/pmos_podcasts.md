# PostmarketOS Podcasts

`gpodder-adaptive` - podcast client

- [PostmarketOS Podcasts](#postmarketos-podcasts)
  - [Installation](#installation)
  - [GPO utilities](#gpo-utilities)
  - [Subscribe to a podcast](#subscribe-to-a-podcast)
  - [List episodes](#list-episodes)
  - [Download an episode](#download-an-episode)
  - [Play an episode](#play-an-episode)
  - [Resources](#resources)


## Installation
```sh
sudo apk add gpodder-adaptive
```

## GPO utilities

```sh
nokia-n900:~$ gpo

gPodder 3.11.5+1 (2024-12-28) - http://gpodder.org/
© 2005-2024 The gPodder Team
License: GNU General Public License, version 3 or later

Entering interactive shell. Type 'help' for help.
Press Ctrl+D (EOF) or type 'quit' to quit.

gpo> help

  Usage: gpo [--verbose|-v|--quiet|-q] [COMMAND] [params...]

  - Subscription management -

    subscribe URL [TITLE]      Subscribe to a new feed at URL (as TITLE)
    search QUERY               Search the gpodder.net directory for QUERY
    toplist                    Show the gpodder.net top-subscribe podcasts

    import FILENAME|URL        Subscribe to all podcasts in an OPML file
    export FILENAME            Export all subscriptions to an OPML file

    rename URL TITLE           Rename feed at URL to TITLE
    unsubscribe URL            Unsubscribe from feed at URL
    enable URL                 Enable feed updates for the feed at URL
    disable URL                Disable feed updates for the feed at URL

    info URL                   Show information about feed at URL
    list                       List all subscribed podcasts
    update [URL]               Check for new episodes (all or only at URL)

  - Episode management -

    download [URL] [GUID]      Download new episodes (all or only from URL) or single GUID
    delete [URL] [GUID]        Delete from feed at URL an episode with given GUID
    pending [URL]              List new episodes (all or only from URL)
    episodes [--guid] [URL]    List episodes with or without GUIDs (all or only from URL)
    partial [--guid]           List partially downloaded episodes with or without GUIDs
    resume [--guid]            Resume partially downloaded episodes or single GUID

  - Episode management -

    sync                       Sync podcasts to device

  - Configuration -

    set [key] [value]          List one (all) keys or set to a new value

  - Extension management -

    extensions [LIST]          List all available extensions
    extension info <NAME>      Information about an extension
    extension enable <NAME>    Enable an extension
    extension disable <NAME>   Disable an extension

  - Other commands -

    youtube URL                Resolve the YouTube URL to a download URL
    rewrite OLDURL NEWURL      Change the feed URL of [OLDURL] to [NEWURL]
```

## Subscribe to a podcast
```sh
gpo> subscribe https://feeds.transistor.fm/cteme-vam-seznam-zpravy
Successfully added https://feeds.transistor.fm/cteme-vam-seznam-zpravy.

gpo> list
# Čteme vám Seznam Zprávy
https://feeds.transistor.fm/cteme-vam-seznam-zpravy
```
## List episodes

```sh
gpo> episodes --guid https://feeds.transistor.fm/cteme-vam-seznam-zpravy
```

## Download an episode

```sh
gpo> download https://feeds.transistor.fm/cteme-vam-seznam-zpravy 31acebf2-5d73-4474-98ab-87888ed425b8
Čteme vám Seznam Zprávy
Downloading Zlato už je tak drahé, že peníze začaly přetékat k jiným k...[DONE]
1 episodes downloaded.
```

## Play an episode

Download folder is `~/gPodder/Downloads/<Podcast name>/`.

```sh
mplayer ~/gPodder/Downloads/Čteme vám Seznam Zprávy/1668ced146919189677fabd0a03d5b94.mp3
```


## Resources
- [gPodder manual](https://gpodder.github.io/docs/user-manual.html#gpoddernet-preferences)
- [postmarketos.org/wiki/GPodder](https://wiki.postmarketos.org/wiki/GPodder)