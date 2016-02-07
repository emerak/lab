$redis = Redis.new(master_name: "master", role: "master",  expires_in: 10.minutes)
