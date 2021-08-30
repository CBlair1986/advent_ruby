# frozen_string_literal:true

task :default do
  FileList['day*.rb'].each { |file| ruby file }
end

task :day, [:day] do |_t, args|
  FileList["day#{args.day}.rb"].each { |file| ruby file }
end
