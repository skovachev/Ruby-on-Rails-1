class Array
  def compress
    table = []
    each do |row|
      target_index = 0
      can_insert = false

      # figure out if it matches
      until can_insert
        can_insert = true

        row.each_with_index do |value, column_index|
          table_value = table[target_index + column_index]
          if !table_value.nil? && !value.nil?
            target_index += 1; can_insert = false
            break
          end
        end
      end

      # insert when matching positions are found
      row.each_with_index do |value, column_index|
        table_index = target_index + column_index
        table[table_index] = [column_index, value] unless value.nil?
      end
    end
    table
  end
end
