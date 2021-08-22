task :default do
	FileList['day*.rb'].each { |file| ruby file }
end