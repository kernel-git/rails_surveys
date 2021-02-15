class SearchRecordsQuery
  def initialize(params = {}, relation = Employee.include(:account))
    @relation = relation
    @params = params
  end

  def all
    result = @relation.none
    @params[:columns].each do |column_name|
      column = @relation.arel_table[column_name]
      result = result.or(@relation.where(column.matches("%#{@params[:search_text.downcase]}%")))
    end
    result
  end
end