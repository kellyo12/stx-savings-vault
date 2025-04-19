;; filepath: c:\Users\HP\Documents\stacks\stx-savings-vault\contracts\stx-savings-vault.clar

;; STX Savings Vault (Yield-Bearing STX Deposits)
;; 
;; Description:
;; Users deposit STX and receive vault shares proportional to their deposit.
;; The vault accumulates yield via an external strategy (set by admin) and
;; distributes rewards to depositors.
;;
;; Admin can set a yield strategy that implements a 'harvest' function.

;; Define the yield strategy trait
(define-trait yield-strategy-trait
  ((harvest () (response uint uint)))
)

;; Replace with your actual admin address - must be a valid Stacks address
(define-constant ADMIN 'SP2J6ZY48GV1EZ5V2V5RB9MP66SW86PYKKNRV9EJ7) 

;; Global state variables
(define-data-var total-deposits uint u0)      ;; Total STX deposited in the vault
(define-data-var reward-pool uint u0)         ;; Accumulated rewards from yield harvesting
(define-map user-balances { user: principal } uint)  ;; Raw STX balance per user
(define-map user-shares { user: principal } uint)    ;; Vault shares per user
(define-data-var total-shares uint u0)        ;; Total vault shares issued
(define-data-var yield-strategy (optional principal) none)  ;; External yield strategy contract

;; -------------------------------
;; Deposit STX into Vault
;; -------------------------------
(define-public (deposit (amount uint))
  (begin
    (asserts! (> amount u0) (err u100))  ;; Deposit must be positive
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
    (let (
          (current-balance (default-to u0 (map-get? user-balances { user: tx-sender })))
          (current-shares (default-to u0 (map-get? user-shares { user: tx-sender })))
          (total-deposited (var-get total-deposits))
          (total-issued-shares (var-get total-shares))
         )
      (let ((new-shares 
              (if (is-eq total-deposited u0)
                  amount
                  (/ (* amount total-issued-shares) total-deposited)
              )))
        (map-set user-balances { user: tx-sender } (+ current-balance amount))
        (map-set user-shares { user: tx-sender } (+ current-shares new-shares))
        (var-set total-deposits (+ total-deposited amount))
        (var-set total-shares (+ total-issued-shares new-shares))
        (ok new-shares)
      )
    )
  )
)

;; ...existing code...