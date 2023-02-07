# frozen_string_literal:true

task :default do
  FileList['day*.rb'].each { |file| ruby file }
end

task :day, [:year, :day] do |_t, args|
  Dir.chdir(args.year) do
    ruby "day#{args.day}.rb"
  end
end
