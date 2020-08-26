# marketplace Application how-to

Even though our Marketplace supports all Operating Systems, this guide focuses on Linux based operating systems. If you want to maintain the application through regular releases we recommend programatically publishing your app with provisioning tools like Ansible, or alternatively our [Terraform integration](github.com/gridscale/terraform-provider-gridscale). We are working on a Packer integration, which will furthermore simplify this process 10x.

## The publish process:

### Create Server + Storage

- Connect the server to the public network, with an IP address.
- The configuration of the server can be lower than what the application needs, the required core and RAM will be set later when publishing the app.

### Install the application

- Install the application to the point where the user would run further install scripts, or before something dynamic like the servers IP address is required.
- Once installed take a note of important variables already set, and these should be echo'd to the terminal once the user logs in, this can be done via the [message of the day](https://infosec.theos-blog.com/how-to-update-the-message-of-the-day-motd-on-ubuntu-18-04/) or any executable script and adding an execution line to `/root/.bashrc`.

### Cleanup the image

- Run the [cleanup.sh](./scripts/cleanup.sh) script to do a soft cleanup of the Storage.

### Take a Snapshot

- once taken, export the snapshot to your Object Storage.

#### Recommendations

- Before taking the final snapshot, run the [cleanup.sh](./scripts/cleanup.sh) script.

- Update all repositories.

- Setup a standard firewall, that allows just enough for the application, and provide this confiration to the user.

- Add a message of the day, this can increase the user experience and also provides an advertisement opportunity (with ASCII art).

- Keep any scripts and custom files that should be removed later on together, for example in `/opt/<application_name>`. This makes cleanup easier before running [cleanup.sh](./scripts/cleanup.sh).

- you should customize the cleanup script, to remove any files, and the script itself.

- Unneccessary tools for running the appication, should be removed to keep things lightweight.

### Publish to the marketplace

Once published - we will review the application and let you know once it has been published.

### Updating / Deprecating the Application

Once accepted, the application can no longer be edited for security reasons. To update the application you will simply need to make the changes to your storage, create another snapshot and export it to S3, from there you can publish the new application version to the marketplace. *As the application creator, you are welcome to remove the app at anytime.*