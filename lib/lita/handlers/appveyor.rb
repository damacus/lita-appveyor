module Lita
  module Handlers
    class Appveyor < Handler
      config :url, default: 'https://ci.appveyor.com/api/projects'
      config :type, default: 'project'
      config :accountName
      config :projectSlug
      config :api_token
      config :branch

      route(/^appveyor\s+(.+)/, :build, help: { 'appveyor build' => 'Builds the latest push to master' })

      require 'httparty'
      def build(resp)
        response = HTTParty.post('https://ci.appveyor.com/api/builds',
                      body: { 'accountName' => config.accountName,
                              'projectSlug' => config.projectSlug,
                              'branch' => config.branch},
                      headers: { 'Authorization' => "Bearer #{config.api_token}" })
        commit = response['commitId']
        status = response['status']

        resp.reply("commit: #{commit} \nstatus: #{status}")
      end

      Lita.register_handler(self)
    end
  end
end
