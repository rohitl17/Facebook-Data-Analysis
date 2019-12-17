# Facebook-Data-Analysis
Facebook statistical data analysis for increasing total page likes for advertising an upcoming brand using R programming(Dataset from Morto et al)

Following is the Link to my blog post which speaks about the purpose and implenetation of the project: https://towardsdatascience.com/brand-marketing-on-facebook-using-statistical-analysis-7ec4210999b0

The detailed documentation of the project is as follows:
1)The total page likes depend on following Facebook Post metrics:
	Total Reach(Number of people who see it)
	Total Impressions(Number of times the post is viewed on facebook(Ex. If your friend shares the post , you see the post twice i.e. once because of the original page post and again due to the shared post,so impressions=2)
	Type of Post(Photo,Status,Video,Link)
	Weekday
	Hour of the day
 
With the help of multiple regression analysis, we get the coefficients for the all the above metrics which help us to determine the importance of each metric in order to increase the number of page likes.
The results show that the number of page likes majorly depend upon totalreach,impressions,type of post(Video,Photo,Link,Status),weekday
Now the main motive is to increase the number of people viewing the post and to increase the number of interactions(like,comment,share) with the post so that a story is created and it automatically appears in the their friends News Feed.
 
The two metrics which depend upon interactions are the Lifetime Post Engaged_Users(Story is created) amd Lifetime Post Consumers(Story not created),also Lifetime Post Consumptions(Single consumer can have more than one consumption)

2) Prediction analysis:
	Here, using the coefficients obtained by multiple regression analysis are used to generate a equation wherein putting the values for the variables the equation predictsthe number of likes depending on the type of post.

3) Post weekday v/s total reach,impressions:
	Here, a line graph is used to show the relation,how a post weekday affects the total reach and impressions in turn affecting the number of page likes.Results show a post posted on weekday 4 gives the best results for reach,impressions

4) Type of post v/s Total reach,impressions
	Here,a bar chart is used to show the relation between the post type and reach,impressions which show that a "video" could be the best for promoting your brand and then a "photo" followed by "link" and "status" 
 
5) Total Interactions v/s Total reach,impressions
	Using linear regression, a graph is plotted that shows the dependency of total interactions on total reach,impressions which in turn would actually allow many viewers to visit the page.

6) Paid post v/s total reach:
	When you pay facebook to promote a post, the total reach ofthe post is increased. So, in order to determine if a post is paid we use a decision tree which shows that if the total reach > 10470, the post is a paid post

7) How many users who have engaged with the post have already liked the page ? The results show 70% people who engage with the post are the ones who have already liked the page. Now , this statistic helps to spread the post amongst their friends and also provokes them to like the post or maybe the page.

8) Till now, we have been focussing on the paramters which directly affect the total page likes. Now, the factors which indirectly affect the total page likes i.e. Engaged users,Consumers,Consumptions are taken into consideration. Here, the statistics are plotted on a pie chart,which help in determining the percentage of consumers,engaged users from the total reach and also the comsumptions,engaged users from the total impressions for every type of post.
This helps in showing whether a particular post type is suitable for increasing the number of interactions and promoting the post.  
