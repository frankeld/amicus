# amicus
⚖️ Adding civic engagement to the courts (VandyHacks VII Entry)

Demo: https://drive.google.com/file/d/12YSBhM6h0cqSGBimAfa6lf-Ccx9Yfq6V/view?usp=sharing

## Inspiration

When people first think of civic engagement, they normally think of voting or reaching out to representatives about issues that matter to them. While these forms of engagement are important to a healthy democracy, we end up ignoring the critical consistent influence of court decisions on the law. So how do we interact with our court system--specifically the Supreme Court?

> ### For some background
> 
> There are three basic types of law, each managed by a different branch of the US government. We take actions on each branch differently:
> 
> -   Statutory law: these are the laws passed by Congress or a local legislative authority
> 	- How We Engage: Voting in congressional elections and communicating with these offices
> - Subordinate legislation: these are regulations are managed by the executive branch
> 	- How We Engage: Voting in presidential elections and local executive elections
> - Common-law precedent: the “unwritten” law created by court decisions and precedent; this third kind of law is actually *on equal footing* with the other two
> 	- How We Engage: Day-of protests at courts
>
>Compared to the first two types, there is a gap for direct engagement with the courts. This gap appears both in how we engage with our courts and what tools exist to directly engage with them. Compared to other branches of government that already have technology and tools created by people, the judicial side of our democracy is left largely untouched. While our elected executive representatives appoint some of our judges, the length of their terms and manner of position do not allow for timely direct engagement.
>
>However, the judiciary’s ability to redefine and manage all other forms of law greatly increases the scope of its influence. Looking back through history, you may notice that the courts have been involved in all areas of law and are responsible for rulings with more far-reaching impact than many pieces of congressional legislation.

Amicus attempts to fill this void. Buried in legal textbooks, the *amicus curiae* (literally meaning “friend on the court”) allows parties not directly associated with a case to provide more documents with pertinent information, expertise, or insight. While they are sometimes filled by public interest organizations for cases with broad public impact, public access is blocked by the complex and unwieldy requirements for submitting these and their relatively obscure status. You can read about these requirements [here](https://supremecourtpress.com/supreme_court_rules.html). It includes things like having them professionally bound with binding in a specific color depending on the stage of the case!

Dreadful forms and paperwork are no more. With Amicus, you can easily submit your thoughts and opinions on a case to be heard by the Supreme Court with a single button. For people who are possibly affected by a case, Amicus simplifies the process for people to show they are experts in their own lives to provide insight into cases that might otherwise be difficult to collect. It then provides an easy way for someone else to take the next step and compile this information into something presentable with one click. 

What Amicus is not (purposefully): There are already so many organizations dedicated towards increasing the ease, scale, and speed at which constituents can interact with their representatives. There are also so many large, public pushes to increase voter registration and turnout. These initiatives are important, but there is already a huge coverage of this area. Amicus is filling a gap these current tools lack.

## What it does

This project has both an iOS app and a web interface. The app is geared towards the public and allows users to create an account, read/learn about cases, and provide opinions. The web interface provides an administrative-type ability to scrape cases for a given year and then view information on those cases (updated from data provided by app users).

After information and opinions get sent to Firestore, the amicus-maker can do all sorts of things with the web interface. First, you can view results and get a sense of what participants are thinking. Participant responses also include their level of activity. Organizers and lawyers using the website can email specific people to hear more of their opinion if they wish. Lastly and most importantly, those managing and using the website can get an auto-generated document with comments and submissions. The document is specially formatted to meet guidelines for an amicus curiae’s submission so it can be directly handed as a valid opinion to courts and their officials.

## How we built it
First, Firestore and the pods needed were set up for this project along with the Xcode workspace. After connecting the workspace to Firestore and manually creating some data points in the database, there were a couple of things that started happening at the same time. On the iOS side, there was a set up of users and their data, along with creating the basic user authentication and information flows. On the web side of things, we reverse engineered different sites to gather the information on cases and synced it to the same data.

On both, the cases page was then set up to have its cells of cases to be programmatically filled in. This allows the app to properly adjust to the intake of cases over the year. Afterwards, the initial case detail & voting page was created. On the iOS app, this page allows users to get a very brief idea of the case at hand, vote and give feedback on the case, or learn more about the case. On the web app, administrators could use the more advanced functionality of setting overrides, generating the doc, and reading all opinions.

We also built out an additional information page and the Safari reader in-app for users who wanted to get a deeper or more technical look at the case without even having to leave the app.

## Challenges we ran into
Let’s just say that [rubber ducks](https://en.wikipedia.org/wiki/Rubber_duck_debugging) have become our best friends :) 

## Accomplishments that we’re proud of
**Victor** - I have never been to a hackathon before, and really had a blast combining my iOS development skills with the social good sector. I have some experience with the tech for social good space, and believe this app pushes into a very unexplored area.

**David** - This was my first time using Flask and Firestore and I was surprised by how quickly I could get it running! And although they weren’t triggered in the demo, I made some really fun loading animations!


## What we learned

Before beginning this project, we both did research into the roles of amicus curiae briefs so we could be sure that the work we were doing was impactful and had realistic applications. Although this isn’t tech-related, it was one of the most important aspects of our project.

**Victor** - I learned a lot about creating different kinds of views in Swift and performing intricate maneuvers with variables. I have a little experience with Firestore, but I’ve never used it this deeply, especially when it comes to collections within collections. I really enjoyed all of the learning and can’t wait to use these skills more!

**David** - Using Flask and its templates was completely new to me and I learned tons about connecting the different views. I also had to sync this with the work that Victor was doing in the front end. Using docxtpl to programmatically edit a Word doc was completely new to me, but it was actually harder to even set up the template in legalese!

## What's next for amicus
We’d love to take a deeper dive into our iOS app and build out even more ways of engagement. With the right marketing, the app could gain a sizable following of people looking for unique ways to contribute to civic and political issues in a simple and engaging way that connects to their lives.

We’d also enjoy expanding our tools so that this app expands past the Supreme Court and into local courts.

Thank you for your time!
