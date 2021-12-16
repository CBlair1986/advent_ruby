# frozen_string_literal:true

task :default do
  FileList['day*.rb'].each { |file| ruby file }
end

task :day, [:year, :day] do |_t, args|
  FileList["./#{args.year}/day#{args.day}.rb"].each { |file| ruby file }
end
