# You can use this class in your console. For example
#   p = ProfilingTools.new
#   p.profiled_request(:controller => :welcome, :action => :index)
# this will profile whole application stack and save file in your tmp/profiler folder
# You can also use +request+ method just to see the output for example:
#
#   p.request(:controller => :offers, :action => :index)
#   
#   p.response.body
#   p.response.cookies # and so on
#
# Here's manual for reading profiler report: http://ruby-prof.rubyforge.org/graph.txt
class ProfilingTool
  attr_accessor :response
  
  def request(options = {})
    url=app.url_for(options)
    app.get(url)
    @response = app.response
    puts app.html_document.root.to_s    
  end

  # use this in production env or other env where you have: config.cache_classes = true
  def profiled_request(options = {})
    require 'ruby-prof'
    # Profile the code
    url = app.url_for(options)
    RubyProf.start
    app.get(url)
    results = RubyProf.stop
    @response = app.response
    save_profiling_results(results)
  end
  
  private
  
  def save_profiling_results(results)
    folder = 'tmp'
    File.open Rails.root.join(folder, 'profile-graph.html'), 'w+' do |file|
      RubyProf::GraphHtmlPrinter.new(results).print(file)
    end
 
    File.open Rails.root.join(folder, "profile-flat.txt"), 'w+' do |file|
      RubyProf::FlatPrinter.new(results).print(file)
    end
 
    File.open Rails.root.join(folder, "profile-tree.prof"), 'w+' do |file|
      RubyProf::CallTreePrinter.new(results).print(file)
    end
  end
end
