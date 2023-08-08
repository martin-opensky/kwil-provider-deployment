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
<img src="https://lets.embrace.community/arweave-hack/kwil-provider.png" style="height: 400px;" />
</div>

When a DB is selected then all the tables and actions are loaded onto the UI.  The Admin user, can navigate between all the tables in the schema.
<div style="display: flex; justify-content: center;">
<img src="https://lets.embrace.community/arweave-hack/kwil-admin.png" style="height: 350px;" />
</div>

All actions are listed on the right side of the UI, and once clicked an action modal will display allowing the input variables to be entered.

<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/kwil-action-list.png" style="height: 200px;" />
</div>
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/kwil-action.png" style="height: 300px;" />
</div>

## Kwil DB Sync & Restore
This tool includes 2 repositories: one is for an extension and the other is for a gRPC server that runs as a container alongside the sync extension.  This tool saves database actions to Arweave (through Bundlr) along with specific tags enabling each action to be easily traced and synced to other Kwil Providers running the service.

**Extension repo**: https://github.com/martin-opensky/kwil-extension-db-sync

**gRPC Server**: https://github.com/martin-opensky/kwil-db-sync-server

When the DB Sync extension is initialised it communicates with the Sync Server to restore any actions that exist on Arweave for that DB ID.  It does this using the Bundlr GraphQL API and the server executes any found actions on the local DB.  This enables DB actions to be re-played when a server has been taken down or when the schema is re-deployed on another server.

Once the initial actions have been restored, the Sync Server will continue to listen for transactions on the GQL Bundlr API for this DB.  This enables another Provider to run on a different server and submit actions to the same DB.  By running 2 or more Providers with this service, specific databases can remain synced.  If all Providers were to be destroyed, there is still the option to fully restore the DB, given the permanent storage of actions on Arweave.

<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/sync-setup.png" style="height: 200px;" />
</div>

<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/sync-function.png" style="height: 300px;" />
</div>

Each action that is synced must have a private equivalent so that the data can be restored by the DB Owner / Admin only.  This is as certain information such as @caller, $date, $id etc could not be replayed successfully at another time by different account.
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/sync-function-owner.png" style="height: 100px;" />
</div>

Once the save_action method is called on the extension the data is saved to Arweave and can be found through the Bundlr GQL API.
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/sync-tags.png" style="height: 400px;" />
</div>

The file stored on Arweave contains information about which action to run and what parameters to use:
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/sync-json.png" style="height: 400px;" />
</div>