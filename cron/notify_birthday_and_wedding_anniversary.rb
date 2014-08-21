require "#{File.expand_path(File.dirname(__FILE__))}/../config/environment"

logger = Logger.new("#{File.expand_path(File.dirname(__FILE__))}/../log/cron.log")

oasis_vijaya_assoc = Member.find_by_name("Oasis Vijaya Association")

Member.find(:all).each do |member|
  next unless member.date_of_birth
  if member.date_of_birth.mday == Date.today.mday
    begin
      oasis_vijaya_assoc.notifications.create!(:title => "Happy birthday #{member.name} of house #{member.house.name}",
                                               :content => "Oasis Vijaya Association would like to congratulate you on your #{Date.today.year - member.date_of_birth.year} birthday. May God bless you and fill your life with more love and happiness.")
      logger.info "Birthday Notifier: Notified birthday for #{member.name}"
    rescue Exception => e
      logger.error "Birthday Notifier: ERROR, \n#{e.backtrace.join("\n\t")}"
    end
  end
end


Member.find(:all).each do |member|
  next unless member.wedding_anniversary
  if member.wedding_anniversary.mday == Date.today.mday
    begin
      oasis_vijaya_assoc.notifications.create!(:title => "Happy wedding anniversary #{member.name} of house #{member.house.name}",
                                               :content => "Oasis Vijaya Association would like to congratulate you on your #{Date.today.year - member.wedding_anniversary.year} wedding anniversary. May God bless you and fill your life with more love and happiness.") 
      logger.info "Wedding Anniversary Notifier: Notified wedding anniversary for #{member.name}, id: #{member.id}"
    rescue Exception => e
      logger.error "Wedding Anniversary Notifier: ERROR, \n#{e.backtrace.join("\n\t")}"
    end
  end
end
