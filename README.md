# 🚀 One Click Multisynq Guide

Automate the setup and background running of the Multisynq Synchronizer CLI on Ubuntu 20.04/22.04 with a single script.

---

## 🖥️ System Requirements

| Requirement     | Recommended Specs         |
|-----------------|--------------------------|
| **RAM**         | 4 GB                     |
| **CPU CORES**   | 2                        |
| **DISK**        | 10 GB NVMe (recommended) |


## Recommended server : https://contabo.com/en/vps/
- Rent VPS10 (4.95$/month)
- Make sure to save your password
- Connect with ssh root@<ip address given in email> on termius
- You're in

---

## 📦 What Does This Script Do?

This one-click script will:

1. **Check your system compatibility**
2. **Update your package index**
3. **Install npm** (if not already present)
4. **Install the synchronizer-cli tool** globally via npm
5. **Install the `screen` utility** (if missing)
6. **Launch the synchronizer node** in a detached background screen session called `synq`
7. **Log all output** to `~/synchronize.log`

You can safely close your terminal—your node keeps running in the background!

---

## ⚡️ Usage

1. **Run the command**

```bash
git clone https://github.com/FragIfty01/Multisynq-Guide && cd Multisynq-Guide && chmod +x setup.sh && sudo ./setup.sh
  ```

---

## 🖥️ Managing Your Synchronizer Session

- **View your running node:**
    ```bash
    screen -r synq
    ```
- **Detach and leave it running:**
    - Press `Ctrl+A`, then `D`
- **View the log file anytime:**
    ```bash
    tail -f ~/synchronize.log
    ```

---

## ℹ️ Notes

- If a `screen` session named `synq` already exists, the script will close it before starting a new one.
- The synchronizer runs even if you log out of your server or close your terminal.
- All main actions and errors are logged in `/var/log/setup-synchronizer-cli.log`.
- The synchronizer's runtime output is saved to `~/synchronize.log`.
- The script only supports Ubuntu 20.04 and 22.04 for now.

---

## 🛑 Troubleshooting

- **If `synchronize start` fails inside the screen:**
    - Check your `~/synchronize.log` for errors.
    - Make sure your system meets the requirements.
    - Try running the command manually in a new terminal:  
      ```bash
      synchronize start
      ```
- **If you can't attach to the screen session:**  
  Check with:
  ```bash
  screen -ls
