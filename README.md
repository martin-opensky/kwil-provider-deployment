# Kwil DB Administrator

For this Arweave Hackathon I have focused on creating extensions and administrative tools for Kwil DB.
There are several repositories included as part of this project but this is the core repository.  Details of the other repositories will be included below.

## About
I am currently working on a Web3 project called Embrace Community and I've been looking for a reliable database that is decentralised and that easily connects to other Web3 infrastructure e.g. Arweave / Ethereum.  
This has been my motivation with creating extensions and tools for Kwil DB during this hackathon.
<div style="display: flex; justify-content: center;">
<img src="https://lets.embrace.community/arweave-hack/me.png" alt="martin" style="height: 200px;" />
</div>

Martin <martin@openskydevelopment.co.uk>

## Prizes
I am submitting code for both Kwil prizes: **Best use of Kwil** and **Best Kwil Extension**.
For the **Best use of Kwil** track I am submitting two projects: Kwil Admin UI and Kwil DB Sync & Restore.
For the **Best Kwil Extension** track I am submitting 3 extensions.
Further details about each project and their repositories is included below.

## Kwil Admin UI
The Kwil Admin UI is built using Next.JS and communicates with the local Kwil Server deployed within a Docker compose environment.  It is a tool to be used by the Kwil DB Administrator only, which means that the account creating all databases remains fixed to the one set in the environment file.  For a full example please see the submission video, however, some screenshots are included below.
**Repo**: https://github.com/martin-opensky/kwil-admin

The Kwil Provider alias *(Provider 1)*, URL and address are loaded from the information set in the ENV file.  Then all databases on the Provider for the Admin account are loaded.
<div style="display: flex; justify-content: center;">
<img src="https://lets.embrace.community/arweave-hack/kwil-provider.png" style="height: 300px;" />
</div>

When a DB is selected then all the tables and actions are loaded onto the UI.  The Admin user, can navigate between all the tables in the schema.
<div style="display: flex; justify-content: center;">
<img src="https://lets.embrace.community/arweave-hack/kwil-admin.png" style="height: 300px;" />
</div>

All actions are listed on the right side of the UI, and once clicked an action modal will display allowing the input variables to be entered.

<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/kwil-action-list.png" style="height: 300px;" />
</div>
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/kwil-action.png" style="height: 200px;" />
</div>


## Kwil DB Sync & Restore
This tool includes 2 repositories: one is for an extension and the other is for a gRPC server that runs as a container alongside the sync extension.  This tool saves database actions to Arweave (through Bundlr) along with specific tags enabling each action to be easily traced and synced to other Kwil Providers running the service.
**Extension repo**: https://github.com/martin-opensky/kwil-extension-db-sync
**gRPC Server**: https://github.com/martin-opensky/kwil-db-sync-server

