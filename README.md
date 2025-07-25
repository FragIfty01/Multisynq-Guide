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

## ⚡️ Installation

1. **Open a screen**

```bash
screen -S synq
  ```
2. **Run the command**

```bash
git clone https://github.com/FragIfty01/Multisynq-Guide && cd Multisynq-Guide && chmod +x setup.sh && sudo ./setup.sh
  ```

3. **Follow all the prompts**

---

## 🖥️ Managing Your Synchronizer Session


- **View your running node:**
    ```bash
    screen -r synq
    ```
- **Detach and leave it running:**
    - Press `Ctrl+A`, then `D`

- **Check your node stats**
     ```bash
    synchronize web
     ```
  - Open the forwarded site to your node stats
    


---

## ℹ️ Notes

- If a `screen` session named `synq` already exists, the script will close it before starting a new one.
- The synchronizer runs even if you log out of your server or close your terminal.




