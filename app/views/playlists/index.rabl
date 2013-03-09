collection @playlists

attributes :name, :id, :created_at, :updated_at

child :items => :items do
  attributes :url, :order, :id, :flavor, :start_time, :end_time
end

