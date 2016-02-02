require 'HTTParty'

response = HTTParty.post('https://ci.appveyor.com/api/builds',
                              body: { 'accountName' => 'hansnqyr', 'projectSlug' => 'drm', 'branch' => 'develop' },
                              headers: { 'Authorization' => 'Bearer s4owahqpg553c8rwjcod' })
commit = response['commitId']
status = response['status']
puts "commit: #{commit} \nstatus: #{status}"
