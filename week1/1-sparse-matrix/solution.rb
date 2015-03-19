class Array
  def compress
    table = []
    each do |row|
      target_idx = 0
      can_insert = false

      # figure out if it matches
      until can_insert
        can_insert = true

        row.each_with_index do |value, column_idx|
          table_value = table[target_idx + column_idx]
          if !table_value.nil? && !value.nil?
            target_idx += 1
            can_insert = false
          end
        end
      end

      # insert when matching positions are found
      row.each_with_index do |value, column_idx|
        table[target_idx + column_idx] = [column_idx, value] unless value.nil?
      end
    end
    table
  end
end
