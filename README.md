puppet-boxcar
=============

Description
-----------

A Puppet report handler for sending notifications of failed runs to Boxcar.

Requirements
------------

* `boxcar_api`
* `puppet`

Installation & Usage
--------------------

1.  Install the `boxcar_api` gem on your Puppet master

        $ sudo gem install boxcar_api

2.  Install puppet-boxcar as a module in your Puppet master's module
    path.

3.  Update the `boxcar_email` and `boxcar_password` variables in the `boxcar.yaml` file with 
    your Boxcar connection details and copy the file to `/etc/puppet/`. You will need to have the 
    Growl service enabled in Boxcar (see the `Add Services` screen on the Boxcar website). This
    service doubles as the API service. An example `boxcar.yaml` file is included.

4.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = boxcar
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

5.  Run the Puppet client and sync the report as a plugin

Author
------

James Turnbull <james@lovedthanlost.net>

License
-------

    Author:: James Turnbull (<james@lovedthanlost.net>)
    Copyright:: Copyright (c) 2011 James Turnbull
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
