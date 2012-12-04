require 'json'; require 'net/https'; require 'uri'
require 'ostruct'

class SonOfAnnotizer


  def initialize(login, password)
  	@login = login
  	@password = password
  end


  def valid_login?
  	response = http_request( "/api/projects.json" )
	return response.is_a? Net::HTTPSuccess
  end 

  def projects
  	json = make_request( "/api/projects.json" )['projects']
	json.map{|proj| 
			proj['project_id'] = proj['id']
			OpenStruct.new(proj) 
	}
	#.map{|proj| proj['document_ids']}.flatten
  end

  def project( project_id )
  	return self.projects.detect {|proj|  proj.project_id.to_s == project_id.to_s }

  	json = make_request( "/api/projects/#{project_id}.json" )

  	Rails.logger.warn json['projects']
	OpenStruct.new( json['projects'][0] )
  end

  def documents_for_project_id( project_id )
  	project = self.project( project_id )
  	project.document_ids[2..5].map do | doc_id |
  		self.document( doc_id )
    end
  end

  def document( document_id )
	json = make_request( "/api/documents/#{document_id}.json" )['document']
	json['document_id'] = json['id']
	['resources','page'].each{| attr | json[attr] = OpenStruct.new(json[ attr ]) }
	json['annotations'] = json['annotations'].map do |note|  
      note['note_id'] = note['id']
      OpenStruct.new(note)
  end
	OpenStruct.new(json )
  end

  private

  def http_request(path)
  	hostname = "www.documentcloud.org"
	http = Net::HTTP.new(hostname, 443)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_PEER

	request = Net::HTTP::Get.new(path)
	request.basic_auth(@login, @password)
	http.request(request)
  end

  def make_request( path )

	return ActiveSupport::JSON.decode( http_request(path).body )
  end	
end
