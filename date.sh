

date -d "1 days ago" +%Y-%m-%d  
date -d "yesterday" +%Y-%m-%d   
date -d "now" +%Y-%m-%d 
date -d "2 days ago" +%Y-%m-%d  
date -d "4 days ago" +%Y-%m-%d 

set -o verbose on
date
date --date=now
date --date=today # same thing
date --date='3 seconds'
date --date='3 seconds ago'
date --date='4 hours'
date --date='4 hours ago'
date --date='tomorrow'
date --date='1 day'
date --date='1 days'
date --date='yesterday'
date --date='1 day ago'
date --date='1 days ago'
date --date='1 week'
date --date='1 fortnight'
date --date='1 month'
date --date='1 year'
