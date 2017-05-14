module SeminarsHelper
 def duration
    @duration = (@seminar.end_date.to_date - @seminar.start_date.to_date).to_i
    if @duration <= 31
       render text:"#{@duration} Days"
   else
     @duration_month = ((12*@duration).to_f/365)
    render text: "#{@duration_month.round(1)} Months"
   end
 end
end