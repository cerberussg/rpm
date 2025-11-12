module ApplicationHelper
  def post_excerpt(post, length: 200)
    # Get plain text from rich text content
    plain_text = post.content.to_plain_text

    # Split by common code block indicators and take only the part before code
    parts = plain_text.split(/(?=class\s+\w+|def\s+\w+|function\s+\w+|const\s+\w+|let\s+\w+|var\s+\w+|import\s+|<\w+|{|}|\[|\])/)
    text_before_code = parts.first || plain_text

    # Clean up the text
    clean_text = text_before_code.strip

    # If the text is shorter than length, return it as is
    return clean_text if clean_text.length <= length

    # Try to cut at sentence boundaries (. ! ?)
    # Find all sentence endings within the length limit
    sentences = clean_text.scan(/[^.!?]+[.!?]+/)

    excerpt = ""
    sentences.each do |sentence|
      if (excerpt + sentence).length <= length
        excerpt += sentence
      else
        break
      end
    end

    # If we got at least one complete sentence, use it
    if excerpt.length > 0 && excerpt.length >= length * 0.5
      return excerpt.strip
    end

    # Otherwise, fall back to word boundary truncation
    truncate(clean_text, length: length, separator: ' ')
  end
end
