module BooksHelper
  def optimize_column(code_info,book)
    book_info=book.volume_info
    title=book_info.title
    subtitle=book_info.subtitle
    publisher=book_info.publisher
    isbn_array=(book_info.industry_identifiers ? book_info.industry_identifiers : nil ) 
    isbn=nil
    # ISBN10がない場合に限ってISBN13など
    # 取り出し時に文字列長を検証する
    unless isbn_array == nil
      if isbn_array.count == 1
        isbn=isbn_array.to_s
      else
        isbn_array.each do |isbn_row|
          if isbn_row.type == 'ISBN_10'
            isbn=isbn_row
          end
        end
      end
    end
    url=book_info.info_link
    image_url=(book_info.image_links ? book_info.image_links.thumbnail : '')
    description=book_info.description
    
    #出版日の抜出
    date=book_info.published_date
    publish_date=nil
    date_array=date.split('-')
    case date_array.count
      when 1
        year=date_array[0].to_i
        publish_date=DateTime.new(year)
      when 2 
        year=date_array[0].to_i
        month=date_array[1].to_i
        publish_date=DateTime.new(year,month)
      when 3 
        year=date_array[0].to_i
        month=date_array[1].to_i
        day=date_array[2].to_i
        publish_date=DateTime.new(year,month,day)
    end
    
    
    
    return{
      title: title,
      subtitle: subtitle,
      publisher: publisher,
      publish_date: publish_date,
      isbn: isbn,
      url: url,
      image_url: image_url,
      description: description,
      code: code_info
    }
     
    
    
  end
end
