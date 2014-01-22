package salesman.model;

public class Post implements Comparable<Post> {

    Long no = 0l;
    int id =0;
	String title;
    String content;
	String reg_id;
    
    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getReg_id() {
		return reg_id;
	}

	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}

    public Post() { }
    
    public Post(String title, String content, String writer) {
        this.title = title;
        this.content = content;
    }
    
    
    public Long getNo() { return no; }
    public Post setNo(Long no) { this.no = no; return this; };
    
    public String getTitle() { return title; }
    public Post setTitle(String title) { this.title = title; return this; };
    
    public String getContent() { return content; }
    public Post setContent(String content) { this.content = content; return this; };
    
    @Override
    public int compareTo(Post target) {
        return no.compareTo(target.no);
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + (int) (no ^ (no >>> 32));
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Post other = (Post) obj;
        if (no != other.no)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "Post [no=" + no + ", title=" + title + ", content=" + content
               + "]";
    }

}
