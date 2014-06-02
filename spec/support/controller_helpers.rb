module ControllerHelpers
  def sign_in(member = double('member'))
    if member.nil?
      request.env['warden'].stub(:authenticate!).
        and_throw(:warden, {:scope => :member})
      controller.stub :current_member => nil
    else
      request.env['warden'].stub :authenticate! => member
      controller.stub :current_member => member
    end
  end
end
