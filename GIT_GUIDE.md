# Git & GitHub Quick Reference Guide

## 🚀 Basic Workflow

### Before You Start Working
Always pull the latest changes from GitHub:
```powershell
git pull
```

### After Making Changes
Follow these three steps to push your changes to GitHub:

```powershell
# 1. Stage all your changes
git add .

# 2. Commit with a descriptive message
git commit -m "Description of what you changed"

# 3. Push to GitHub
git push
```

---

## 📋 Essential Commands

### Check Status
See what files have been modified:
```powershell
git status
```

### View Commit History
See your recent commits:
```powershell
git log --oneline
```

### Pull Latest Changes
Download updates from GitHub:
```powershell
git pull
```

### Push Your Changes
Upload your commits to GitHub:
```powershell
git push
```

---

## 🔄 Complete Daily Workflow

```powershell
# Morning: Get latest version
git pull

# ... make your changes to files ...

# Evening: Save and upload
git add .
git commit -m "Added new calculations for U-235"
git push
```

---

## 💡 Commit Message Tips

Good commit messages are clear and descriptive:

✅ **Good Examples:**
- `"Add thorium fuel calculations"`
- `"Fix cross-section data for Pu-239"`
- `"Update README with installation instructions"`
- `"Add new graphs for neutron spectrum analysis"`

❌ **Bad Examples:**
- `"update"`
- `"fix"`
- `"changes"`

---

## 🆘 Common Issues & Solutions

### Problem: "Your branch is behind"
**Solution:** Pull first, then push
```powershell
git pull
git push
```

### Problem: Modified files not showing up
**Solution:** Make sure to add them
```powershell
git add .
git status  # Verify files are staged
git commit -m "Your message"
git push
```

### Problem: Want to undo local changes
**Solution:** Restore from last commit
```powershell
git restore <filename>
```

---

## 📁 Working with Specific Files

### Add specific files only
```powershell
git add filename.ipynb
git add data/new_data.xlsx
```

### Check changes in a specific file
```powershell
git diff filename.ipynb
```

---

## 🌿 Branch Management (Advanced)

### Create a new branch for experimental work
```powershell
git checkout -b experiment-new-feature
```

### Switch back to main branch
```powershell
git checkout main
```

### List all branches
```powershell
git branch
```

---

## 📊 View Your Repository Online

Your repository URL:
**https://github.com/tjvanrooyen/Nuclear-Engineering-Science-Codes**

---

## 🎯 Quick Command Summary

| Command | Purpose |
|---------|---------|
| `git pull` | Download latest from GitHub |
| `git add .` | Stage all changes |
| `git commit -m "msg"` | Save changes with message |
| `git push` | Upload to GitHub |
| `git status` | Check file status |
| `git log --oneline` | View commit history |
| `git diff` | See what changed |

---

## 📞 Need Help?

- Check status: `git status`
- View this guide: Open `GIT_GUIDE.md`
- GitHub repository: https://github.com/tjvanrooyen/Nuclear-Engineering-Science-Codes

---

*Last updated: October 21, 2025*
