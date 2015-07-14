class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ", "").length

    @word_count = @text.split.count

    @occurrences = @text.upcase.split.count(@special_word.upcase)
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment =@principal*((@apr/100)/(12.0*(1.0-(1.0+(@apr/100)/12.0)**(-@years*12.0))))
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = (@ending.to_i - @starting.to_i)
    @minutes = (@ending.to_f - @starting.to_f)/60
    @hours = (@ending.to_f - @starting.to_f)/60/60
    @days = (@ending.to_f - @starting.to_f)/60/60/24
    @weeks = (@ending.to_f - @starting.to_f)/60/60/24/7
    @years = (@ending.to_f - @starting.to_f)/60/60/24/365
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    @sample = 0

    @numbers.each do |num|
        @sample = @sample + num
    end

    @testing
    if @count % 2 == 0
        @median = (@sorted_numbers[@count/2].to_f + @sorted_numbers[@count/2-1].to_f)/2
    elsif @count % 2 == 1
        @median = @sorted_numbers[(@count.to_f/2.0-0.5).to_i]
    end


    # @median = @testing

    @sum = @sample

    @mean = @sample.to_f/@count.to_f

    @sq_diff = 0.0

    @numbers.each do |num|
        @sq_diff += (num - @mean)**2
    end

    @variance = @sq_diff/@count

    @standard_deviation = @variance**(0.5)

    @counted_array= []

    for i in 0..(@numbers.count-1)
        @counted_array.push(Array[0])
    end

    for i in 0..(@sorted_numbers.count-1)
        for j in 0..(@sorted_numbers.count-1)
            if @sorted_numbers[i]==@sorted_numbers[j]
                @counted_array[i][0] += 1
                @counted_array[i].push(@sorted_numbers[i])
            end
        end
    end
    @highest

    for i in 0..(@sorted_numbers.count-1)
        if @sorted_numbers[i].to_i == @counted_array.max[1].to_i
            @highest = @sorted_numbers[i]
            break
        end
    end

    @mode = @highest
  end
end
