## My Data Cleaning Decisions — Explained Simply

I started with 37 columns and ended with 12 columns to actually use in my model.
Here's why I removed each group of columns.

---

### Group 1: Columns with too many blanks

If most people never answered a question, I can't trust that column.
Filling in the blanks would mean guessing, not learning from real answers.

- **How did you hear about X Education** — 78 out of 100 people left this blank
- **Lead Profile** — 74 out of 100 people left this blank (some had "Select" 
  which is a fake answer left by an empty dropdown — same as blank)
- **The 4 "Asymmetrique" score columns** — almost half of everyone left these blank

I dropped all of these because there just wasn't enough real information in them.

---

### Group 2: Columns that secretly reveal the answer (cheating columns)

These columns only get filled in AFTER a salesperson has already talked to
the lead and knows what happened. Using them would be like a model peeking
at the answer key.

- **Lead Quality** — this is a salesperson's personal opinion, written after 
  they called the person. I proved this: almost everyone marked "High in 
  Relevance" actually converted, and almost no one marked it who didn't 
  convert. That's way too perfect — it's basically the salesperson already 
  telling us the answer.
- **Tags** — these are notes salespeople write during/after calling someone, 
  like "invalid number" or "Closed the deal." Same problem — written after 
  the outcome is already known.

**One column I checked but did NOT remove:** `Last Notable Activity` (things 
like "Email Opened" or "SMS Sent"). I thought this might be cheating too, but 
it's actually different — these are automatic system logs, not a person's 
opinion. The system logs "Email Opened" the second someone opens an email, 
with no human deciding anything. So this one is fair to keep, even though 
it also correlates with conversion.

---

### Group 3: Columns where almost everyone gave the same answer

If 99% of people answer the exact same thing, that column can't help me tell 
people apart. It's like asking "do you have a heartbeat?" — everyone says yes, 
so the question is useless for spotting differences between people.

Columns I dropped for this reason:
- What matters most to you in choosing a course (99.95% said the same thing)
- Country (97% were from India)
- Search, Magazine, Newspaper Article, X Education Forums, Newspaper, 
  Digital Advertisement, Through Recommendations (all 99%+ said "No")
- Do Not Call (99.98% said "No")
- Receive More Updates / Update me on Supply Chain / Get updates on DM 
  Content / I agree to pay by cheque (100% said "No" — literally everyone, 
  no exceptions)

---

### Group 4: Columns that are just ID numbers

- **Prospect ID** and **Lead Number** — these are just row numbers, like a 
  ticket number at a bakery. They don't describe the person at all, so they 
  can't help predict anything about them.

---

### Columns that LOOKED suspicious but I kept them (and why)

- **Do Not Email** — 8% said "Yes." That might sound small, but compare it 
  to Group 3 above where the "different" answer was often under 1%. 8% with 
  734 real people is actually a solid, meaningful group — worth keeping.
- **A free copy of Mastering The Interview** — a nice, healthy mix (69% No, 
  31% Yes). Also, this is something a person chooses for themselves on the 
  form, before anyone calls them — so it's not cheating either.
- **Last Notable Activity** — explained above, it's a system log, not a 
  person's after-the-fact opinion.

---

### My final 12 columns I'm actually using to build the model:

1. Lead Origin
2. Lead Source
3. Do Not Email
4. TotalVisits
5. Total Time Spent on Website
6. Page Views Per Visit
7. Last Activity
8. Specialization
9. What is your current occupation
10. City
11. A free copy of Mastering The Interview
12. Last Notable Activity