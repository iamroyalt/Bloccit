module LabelsHelper
  def labels_to_buttons(labels)
      raw labels.map { |l| link_to l.name, label_path(id: l.id), class: 'btn-xs btn-primary' }.join(' ')
    end
end

#raw tells Ruby to call map without escaping the string that is returned
#map iterates over the labels array for each item in the array.
#map creates a link (using link_to) to each label path using label_path(id: l.id).
#The link is displayed as l.name (the first parameter passed to link_to) and is styled by the third parameter to link_to, class: 'btn-xs btn-primary'.
#We then join each of these HTML generated links and separate them with a space using .join(' ').
