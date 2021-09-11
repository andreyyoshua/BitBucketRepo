//
//  RepoRawJSON.swift
//  BitBucketRepoTests
//
//  Created by Andrey Yoshua on 11/09/21.
//

import Foundation

let json = """
    {
      "pagelen": 10,
      "values": [
        {
          "scm": "git",
          "website": "",
          "has_wiki": false,
          "uuid": "{3f630668-75f1-4903-ae5e-8ea37437e09e}",
          "links": {
            "watchers": {
              "href": "https://api.bitbucket.org/2.0/repositories/opensymphony/xwork/watchers"
            },
            "branches": {
              "href": "https://api.bitbucket.org/2.0/repositories/opensymphony/xwork/refs/branches"
            },
            "tags": {
              "href": "https://api.bitbucket.org/2.0/repositories/opensymphony/xwork/refs/tags"
            },
            "commits": {
              "href": "https://api.bitbucket.org/2.0/repositories/opensymphony/xwork/commits"
            },
            "clone": [
              {
                "href": "https://bitbucket.org/opensymphony/xwork.git",
                "name": "https"
              },
              {
                "href": "git@bitbucket.org:opensymphony/xwork.git",
                "name": "ssh"
              }
            ],
            "self": {
              "href": "https://api.bitbucket.org/2.0/repositories/opensymphony/xwork"
            },
            "source": {
              "href": "https://api.bitbucket.org/2.0/repositories/opensymphony/xwork/src"
            },
            "html": {
              "href": "https://bitbucket.org/opensymphony/xwork"
            },
            "avatar": {
              "href": "https://bytebucket.org/ravatar/%7B3f630668-75f1-4903-ae5e-8ea37437e09e%7D?ts=java"
            },
            "hooks": {
              "href": "https://api.bitbucket.org/2.0/repositories/opensymphony/xwork/hooks"
            },
            "forks": {
              "href": "https://api.bitbucket.org/2.0/repositories/opensymphony/xwork/forks"
            },
            "downloads": {
              "href": "https://api.bitbucket.org/2.0/repositories/opensymphony/xwork/downloads"
            },
            "pullrequests": {
              "href": "https://api.bitbucket.org/2.0/repositories/opensymphony/xwork/pullrequests"
            }
          },
          "fork_policy": "allow_forks",
          "full_name": "opensymphony/xwork",
          "name": "xwork",
          "project": {
            "links": {
              "self": {
                "href": "https://api.bitbucket.org/2.0/workspaces/opensymphony/projects/PROJ"
              },
              "html": {
                "href": "https://bitbucket.org/opensymphony/workspace/projects/PROJ"
              },
              "avatar": {
                "href": "https://bitbucket.org/account/user/opensymphony/projects/PROJ/avatar/32?ts=1543460518"
              }
            },
            "type": "project",
            "name": "Untitled project",
            "key": "PROJ",
            "uuid": "{57fac509-0df2-47ce-ad8e-27be013523fa}"
          },
          "language": "java",
          "created_on": "2011-06-06T03:40:09.505792+00:00",
          "mainbranch": {
            "type": "branch",
            "name": "master"
          },
          "workspace": {
            "slug": "opensymphony",
            "type": "workspace",
            "name": "opensymphony",
            "links": {
              "self": {
                "href": "https://api.bitbucket.org/2.0/workspaces/opensymphony"
              },
              "html": {
                "href": "https://bitbucket.org/opensymphony/"
              },
              "avatar": {
                "href": "https://bitbucket.org/workspaces/opensymphony/avatar/?ts=1543460518"
              }
            },
            "uuid": "{cedfd0d1-899f-49de-acf7-a2fa8e924b6f}"
          },
          "has_issues": false,
          "owner": {
            "display_name": "opensymphony",
            "uuid": "{cedfd0d1-899f-49de-acf7-a2fa8e924b6f}",
            "links": {
              "self": {
                "href": "https://api.bitbucket.org/2.0/users/%7Bcedfd0d1-899f-49de-acf7-a2fa8e924b6f%7D"
              },
              "html": {
                "href": "https://bitbucket.org/%7Bcedfd0d1-899f-49de-acf7-a2fa8e924b6f%7D/"
              },
              "avatar": {
                "href": "https://bitbucket.org/account/opensymphony/avatar/"
              }
            },
            "type": "user",
            "nickname": "opensymphony",
            "account_id": null
          },
          "updated_on": "2014-11-16T23:19:16.674082+00:00",
          "size": 22877949,
          "type": "repository",
          "slug": "xwork",
          "is_private": false,
          "description": ""
        }
      ],
      "next": "https://api.bitbucket.org/2.0/repositories?after=2011-09-03T12%3A33%3A16.028393%2B00%3A00"
    }
    """
