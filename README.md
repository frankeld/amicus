# amicus
⚖️ Adding civic engagement to the courts (VandyHacks VII Entry)

## Inspiration

When people first think of civic engagement, they normally think of voting or reaching out to representatives about issues that matter to them. While these forms of engagement are critical to a healthy democracy, we end up ignoring the consistent influence of court decisions on law.

> ### For some background
> 
> There are three basic types of law, each managed by a different branch of the US government:
> 
> -   Statutory law: these are the laws passed by Congress or a local legislative authority
> 	- How We Engage: Voting in congressional elections and communicating with these offices
> - Subordinate legislation: these are regulations are managed by the executive branch
> 	- How We Engage: Voting in presidential elections and local executive elections
> - Common-law precedent: the “unwritten” law created by court decisions and precedent; this third kind of law is actually *on equal footing* with the other two
> 	- How We Engage: Day-of protests at courts
>
>Compared to the first two types, there is a gap for direct engagement with the courts. While our elected executive representatives appoint some of our judges, the length of their terms and manner of position do not allow for timely direct engagement.
>
>However, the judiciary’s ability to redefine and manage all other forms of law greatly increases the scope of its influence. Looking back through history, you may notice that the courts have been involved in all areas of law and are responsible for rulings with more far-reaching impact than many pieces of Congressional legislation.

Amicus attempts to fill this void. Buried in legal textbooks, the *amicus curiae* (literally meaning “friend on the court”) allows parties not directly associated with a case to provide more documents with pertinent information, expertise, or insight. While they are sometimes filled by public interest organizations for cases with broad public impact, public access is blocked by the complex and unwieldy requirements for submitting these and their relatively obscure status. You can read about these requirements [here](https://supremecourtpress.com/supreme_court_rules.html). It includes things like having them professionally bound with binding in a specific color depending on the stage of the case!

Amicus simplifies the process for people who are affected by issues and experts in their own lives to provide insight into cases that might otherwise be difficult to collect. It then provides an easy way for someone else to take the next step and compile this information into something presentable. 

What it’s not (purposefully): There are already so many organizations dedicated towards increasing the ease, scale, and speed at which constituents can interact with their representatives. There are also so many large, public pushes to increase voter registration and turnout. These initiatives are important, but there is already a huge coverage of this area. Amicus is filling a gap where these lack.

## What it does

This app and web interface has a couple of different parts. The web interface provides an administrative-type ability to manage and automatically scrape/update all cases waiting to be heard from a website. Secondly, the iOS app works with that data to enable users to submit opinions on the case, referencing simplified case data.

After information and opinions get sent to Firestore, the amicus-maker can do all sorts of different things with the web interface. First, you can view results and get a sense of what participants are thinking. Participant responses also include level activity. Organizers and lawyers using the website can email specific people to hear more of their opinion if they wish. Lastly and most importantly, those managing and using the website can get an auto-generated document with comments and submissions. The document is specially formatted to meet guidelines for an amicus curiae’s submission so it can be directly handed as valid opinion to courts and their officials.
.
## How we built it

First, Firestore and the pods needed were set up for this project along with the Xcode workspace.

After connecting the workspace to Firestore and manually creating some data points in the database, there were a couple of things that started happening at the same time. On the iOS side, there was a set up of users and their data. On the web side of things, we reverse engineered various components.

The cases page was then set up to have its cells of cases be programmatically filled in. This allows the app to properly adjust to intake of cases over the year. Afterwards, the initial case detail & voting page was created. This page allows users to get a very brief idea of the case at hand, vote and give feedback on the case, or learn more about the case.

The app still was not complete. The additional information page was built out, and if users still are not satisfied they could use the simple Safari reader in-app to get a deeper or more technical look at the case without even having to leave the app.

Next, we wanted to have a system where people on the website could add notes to the bill if they submitted them on the website interface. Once that piece was implemented, a quick onboarding process was drummed up for those who sign up.

## Challenges I ran into
Occasionally, we ran into Xcode issues with topics that weren’t covered in a class. We also made changes to our data structure in Firebase when we noticed that some methods of organization would be more efficient.

## Accomplishments that I'm proud of
Victor - I have never been to a hackathon before, and really had a blast combining my iOS development skills with the social good sector. I have some experience with the tech for social good space, and believe this app pushes into a very unexplored space.
David - This was my first time using Flask and Firestore and I was surprised by how quickly I could get it running!


## What I learned
Usually when you’re working on a project, you’re very pointed towards one area (ex. Just front-end or back-end). This project differed greatly due to the many different platforms and methods of functionality, which made sure we were very in tune with Firestone and keeping track of how we wanted our data structure to work

## What's next for amicus
We’d love to take a deeper look into our iOS app code, make it a bit more visually appealing, and look more into marketing this app. We believe that with the right marketing, the app can quickly gain a large following since many people are looking to contribute more on civic and political issues in a simple and engaging way.
