class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy] #call b4 action that contains @article = Article.find(params[:id])
  #restriction action
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    #grab all article in database
    #but using pagination...how much per page...to reduce an instance varible get too much to handle all data
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  #define new.html.erb
  def new
    @article = Article.new
  end

  def edit
    #@article = Article.find(params[:id])  ..no need this becuz already call at before_action
  end

  def create
    @article = Article.new(article_params) #article params, use for submitting the right value and it's a method !
    @article.user = current_user #require the current session user for creating new article
    if @article.save
      flash[:success] = "Article was successfully created!"
      redirect_to article_path(@article)
    else
      #means if article is not save becuz of validation or something like that so we render it again
      render 'new' #render new template again
    end
  end

  def update
    #@article = Article.find(params[:id])  ..no need this becuz already call at before_action
    if @article.update(article_params) #same as create def, call article_params again
      flash[:success] = "Article was successfully updated!"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show
    #@article = Article.find(params[:id])  ..no need this becuz already call at before_action
  end

  def destroy
    #@article = Article.find(params[:id])  ..no need this becuz already call at before_action
    @article.destroy
    flash[:danger] = "Article was successfully deleted!"
    redirect_to articles_path
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description, category_ids: []) #it use article model to do the action such as validation..refer back at article model!
      #category_ids is at arry form!
    end

    def require_same_user
      if current_user != @article.user and !current_user.admin?
        flash[:danger] = "Forbidden!! You can only edit or delete your own articles!"
        redirect_to articles_path
      end
    end

end
