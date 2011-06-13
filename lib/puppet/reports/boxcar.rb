require 'puppet'
require 'yaml'

begin
  require 'boxcar_api'
rescue LoadError => e
  Puppet.info "You need the `boxcar_api` gem to use the Boxcar report"
end

Puppet::Reports.register_report(:boxcar) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "boxcar.yaml"])
  raise(Puppet::ParseError, "Boxcar report config file #{configfile} not readable") unless File.exist?(configfile)
  config = YAML.load_file(configfile)
  BOXCAR_EMAIL = config[:boxcar_email]
  BOXCAR_PASSWORD = config[:boxcar_password]

  desc <<-DESC
  Send notification of failed reports to Boxcar.
  DESC

  def process
    if self.status == 'failed'
      Puppet.debug "Sending status for #{self.host} to Boxcar."
      bu = BoxcarAPI::User.new(BOXCAR_EMAIL, BOXCAR_PASSWORD)
      res = bu.notify("Puppet run for #{self.host} #{self.status} at #{Time.now.asctime}", "Puppet")
      if res == 200
        Puppet.debug "Boxcar notification successful!"
      else
        Puppet.debug "There was a problem delivering the Boxcar notification, HTTP status code: #{res.code}"
      end
    end
  end
end
