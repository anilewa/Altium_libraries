/*  $OpenBSD: ieee80211_node.h,v 1.41 2009/03/26 20:38:29 damien Exp $  */
/*  $NetBSD: ieee80211_node.h,v 1.9 2004/04/30 22:57:32 dyoung Exp $    */

/*-
 * Copyright (c) 2001 Atsushi Onoe
 * Copyright (c) 2002, 2003 Sam Leffler, Errno Consulting
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $FreeBSD: src/sys/net80211/ieee80211_node.h,v 1.10 2004/04/05 22:10:26 sam Exp $
 */
#ifndef _NET80211_IEEE80211_NODE_H_
#define _NET80211_IEEE80211_NODE_H_

#define IEEE80211_PSCAN_WAIT    5       /* passive scan wait */
#define IEEE80211_TRANS_WAIT    5       /* transition wait */
#define IEEE80211_INACT_WAIT    5       /* inactivity timer interval */
#define IEEE80211_INACT_MAX (300/IEEE80211_INACT_WAIT)
#define IEEE80211_CACHE_SIZE    100

struct ieee80211_rateset {
    u_int8_t        rs_nrates;
    u_int8_t        rs_rates[IEEE80211_RATE_MAXSIZE];
};

extern const struct ieee80211_rateset ieee80211_std_rateset_11a;
extern const struct ieee80211_rateset ieee80211_std_rateset_11b;
extern const struct ieee80211_rateset ieee80211_std_rateset_11g;

enum ieee80211_node_state {
    IEEE80211_STA_CACHE,    /* cached node */
    IEEE80211_STA_BSS,  /* ic->ic_bss, the network we joined */
    IEEE80211_STA_AUTH, /* successfully authenticated */
    IEEE80211_STA_ASSOC,    /* successfully associated */
    IEEE80211_STA_COLLECT   /* This node remains in the cache while
                 * the driver sends a de-auth message;
                 * afterward it should be freed to make room
                 * for a new node.
                 */
};

#define ieee80211_node_newstate(__ni, __state)  \
    do {                    \
        (__ni)->ni_state = (__state);   \
    } while (0)

enum ieee80211_node_psstate {
    IEEE80211_PS_AWAKE,
    IEEE80211_PS_DOZE
};

#define IEEE80211_PS_MAX_QUEUE  50  /* maximum saved packets */

/* Authenticator state machine: 4-Way Handshake (see 8.5.6.1.1) */
enum {
    RSNA_INITIALIZE,
    RSNA_AUTHENTICATION,
    RSNA_AUTHENTICATION_2,
    RSNA_INITPMK,
    RSNA_INITPSK,
    RSNA_PTKSTART,
    RSNA_PTKCALCNEGOTIATING,
    RSNA_PTKCALCNEGOTIATING_2,
    RSNA_PTKINITNEGOTIATING,
    RSNA_PTKINITDONE,
    RSNA_DISCONNECT,
    RSNA_DISCONNECTED
};

/* Authenticator state machine: Group Key Handshake (see 8.5.6.1.2) */
enum {
    RSNA_IDLE,
    RSNA_REKEYNEGOTIATING,
    RSNA_REKEYESTABLISHED,
    RSNA_KEYERROR
};

struct ieee80211_rxinfo {
    u_int32_t       rxi_flags;
    u_int32_t       rxi_tstamp;
    int         rxi_rssi;
};
#define IEEE80211_RXI_HWDEC     0x00000001
#define IEEE80211_RXI_AMPDU_DONE    0x00000002

/* Block Acknowledgement Record */
struct ieee80211_tx_ba {
    struct ieee80211_node   *ba_ni; /* backpointer for callbacks */
    struct timeout      ba_to;
    int         ba_timeout_val;
#define IEEE80211_BA_MIN_TIMEOUT    (10 * 1000)     /* 10msec */
#define IEEE80211_BA_MAX_TIMEOUT    (10 * 1000 * 1000)  /* 10sec */

    int         ba_state;
#define IEEE80211_BA_INIT   0
#define IEEE80211_BA_REQUESTED  1
#define IEEE80211_BA_AGREED 2

    u_int16_t       ba_winstart;
    u_int16_t       ba_winend;
    u_int16_t       ba_winsize;
#define IEEE80211_BA_MAX_WINSZ  128 /* maximum we will accept */

    u_int8_t        ba_token;
};

struct ieee80211_rx_ba {
    struct ieee80211_node   *ba_ni; /* backpointer for callbacks */
    struct {
        struct mbuf     *m;
        struct ieee80211_rxinfo rxi;
    }           *ba_buf;
    struct timeout      ba_to;
    int         ba_timeout_val;
    int         ba_state;
    u_int16_t       ba_winstart;
    u_int16_t       ba_winend;
    u_int16_t       ba_winsize;
    u_int16_t       ba_head;
};

/*
 * Node specific information.  Note that drivers are expected
 * to derive from this structure to add device-specific per-node
 * state.  This is done by overriding the ic_node_* methods in
 * the ieee80211com structure.
 */
struct ieee80211_node {
    //RB_ENTRY(ieee80211_node)    ni_node;
    struct {
    struct ieee80211_node *rbe_left;      /* left element */
    struct ieee80211_node *rbe_right;     /* right element */
    struct ieee80211_node *rbe_parent;    /* parent element */
    int rbe_color;                        /* node color */
    } ni_node;

    struct ieee80211com *ni_ic;     /* back-pointer */

    u_int           ni_refcnt;
    u_int           ni_scangen; /* gen# for timeout scan */

    /* hardware */
    u_int32_t       ni_rstamp;  /* recv timestamp */
    u_int8_t        ni_rssi;    /* recv ssi */

    /* header */
    u_int8_t        ni_macaddr[IEEE80211_ADDR_LEN];
    u_int8_t        ni_bssid[IEEE80211_ADDR_LEN];

    /* beacon, probe response */
    u_int8_t        ni_tstamp[8];   /* from last rcv'd beacon */
    u_int16_t       ni_intval;  /* beacon interval */
    u_int16_t       ni_capinfo; /* capabilities */
    u_int8_t        ni_esslen;
    u_int8_t        ni_essid[IEEE80211_NWID_LEN];
    struct ieee80211_rateset ni_rates;  /* negotiated rate set */
    u_int8_t        *ni_country;    /* country information XXX */
    struct ieee80211_channel *ni_chan;
    u_int8_t        ni_erp;     /* 11g only */

#ifdef notyet
    /* DTIM and contention free period (CFP) */
    u_int8_t        ni_dtimperiod;
    u_int8_t        ni_cfpperiod;   /* # of DTIMs between CFPs */
    u_int16_t       ni_cfpduremain; /* remaining cfp duration */
    u_int16_t       ni_cfpmaxduration;/* max CFP duration in TU */
    u_int16_t       ni_nextdtim;    /* time to next DTIM */
    u_int16_t       ni_timoffset;
#endif

    /* power saving mode */
    u_int8_t        ni_pwrsave;
    struct ifqueue      ni_savedq;  /* packets queued for pspoll */

    /* RSN */
    struct timeout      ni_eapol_to;
    u_int           ni_rsn_state;
    u_int           ni_rsn_gstate;
    u_int           ni_rsn_retries;
    u_int           ni_rsnprotos;
    u_int           ni_rsnakms;
    u_int           ni_rsnciphers;
    enum ieee80211_cipher   ni_rsngroupcipher;
    enum ieee80211_cipher   ni_rsngroupmgmtcipher;
    u_int16_t       ni_rsncaps;
    enum ieee80211_cipher   ni_rsncipher;
    u_int8_t        ni_nonce[EAPOL_KEY_NONCE_LEN];
    u_int8_t        ni_pmk[IEEE80211_PMK_LEN];
    u_int8_t        ni_pmkid[IEEE80211_PMKID_LEN];
    u_int64_t       ni_replaycnt;
    u_int8_t        ni_replaycnt_ok;
    u_int64_t       ni_reqreplaycnt;
    u_int8_t        ni_reqreplaycnt_ok;
    u_int8_t        *ni_rsnie;
    struct ieee80211_key    ni_pairwise_key;
    struct ieee80211_ptk    ni_ptk;
    u_int8_t        ni_key_count;
    int         ni_port_valid;

    /* SA Query */
    u_int16_t       ni_sa_query_trid;
    struct timeout      ni_sa_query_to;
    int         ni_sa_query_count;

    /* Block Ack records */
    struct ieee80211_tx_ba  ni_tx_ba[IEEE80211_NUM_TID];
    struct ieee80211_rx_ba  ni_rx_ba[IEEE80211_NUM_TID];

    /* others */
    u_int16_t       ni_associd; /* assoc response */
    u_int16_t       ni_txseq;   /* seq to be transmitted */
    u_int16_t       ni_rxseq;   /* seq previous received */
    u_int16_t       ni_qos_txseqs[IEEE80211_NUM_TID];
    u_int16_t       ni_qos_rxseqs[IEEE80211_NUM_TID];
    int         ni_fails;   /* failure count to associate */
    int         ni_inact;   /* inactivity mark count */
    int         ni_txrate;  /* index to ni_rates[] */
    int         ni_state;

    u_int16_t       ni_flags;   /* special-purpose state */
#define IEEE80211_NODE_ERP      0x0001
#define IEEE80211_NODE_QOS      0x0002
#define IEEE80211_NODE_REKEY        0x0004  /* GTK rekeying in progress */
#define IEEE80211_NODE_RXPROT       0x0008  /* RX protection ON */
#define IEEE80211_NODE_TXPROT       0x0010  /* TX protection ON */
#define IEEE80211_NODE_TXRXPROT \
    (IEEE80211_NODE_TXPROT | IEEE80211_NODE_RXPROT)
#define IEEE80211_NODE_RXMGMTPROT   0x0020  /* RX MMPDU protection ON */
#define IEEE80211_NODE_TXMGMTPROT   0x0040  /* TX MMPDU protection ON */
#define IEEE80211_NODE_MFP      0x0080  /* MFP negotiated */
#define IEEE80211_NODE_PMK      0x0100  /* ni_pmk set */
#define IEEE80211_NODE_PMKID        0x0200  /* ni_pmkid set */
#define IEEE80211_NODE_HT       0x0400  /* HT negotiated */
#define IEEE80211_NODE_SA_QUERY     0x0800  /* SA Query in progress */
#define IEEE80211_NODE_SA_QUERY_FAILED  0x1000  /* last SA Query failed */
};

// BL[MAC_EXP]
// RB_HEAD(ieee80211_tree, ieee80211_node);
struct ieee80211_tree {
    struct ieee80211_node *rbh_root; /* root of the tree */
};

#define ieee80211_node_incref(ni)           \
    do {                        \
        int _s = splnet();          \
        (ni)->ni_refcnt++;          \
        splx(_s);               \
    } while (0)

static __inline int
ieee80211_node_decref(struct ieee80211_node *ni)
{
    int refcnt, s;
    s = splnet();
    refcnt = --ni->ni_refcnt;
    splx(s);
    return refcnt;
}

static __inline struct ieee80211_node *
ieee80211_ref_node(struct ieee80211_node *ni)
{
    ieee80211_node_incref(ni);
    return ni;
}

static __inline void
ieee80211_unref_node(struct ieee80211_node **ni)
{
    ieee80211_node_decref(*ni);
    *ni = NULL;         /* guard against use */
}

struct ieee80211com;

#ifdef MALLOC_DECLARE
MALLOC_DECLARE(M_80211_NODE);
#endif

extern  void ieee80211_node_attach(struct ifnet *);
extern  void ieee80211_node_lateattach(struct ifnet *);
extern  void ieee80211_node_detach(struct ifnet *);

extern  void ieee80211_begin_scan(struct ifnet *);
extern  void ieee80211_next_scan(struct ifnet *);
extern  void ieee80211_end_scan(struct ifnet *);
extern  void ieee80211_reset_scan(struct ifnet *);
extern  struct ieee80211_node *ieee80211_alloc_node(struct ieee80211com *,
        const u_int8_t *);
extern  struct ieee80211_node *ieee80211_dup_bss(struct ieee80211com *,
        const u_int8_t *);
extern  struct ieee80211_node *ieee80211_find_node(struct ieee80211com *,
        const u_int8_t *);
extern  struct ieee80211_node *ieee80211_find_rxnode(struct ieee80211com *,
        const struct ieee80211_frame *);
extern  struct ieee80211_node *ieee80211_find_txnode(struct ieee80211com *,
        const u_int8_t *);
extern  struct ieee80211_node *
        ieee80211_find_node_for_beacon(struct ieee80211com *,
        const u_int8_t *, const struct ieee80211_channel *,
        const char *, u_int8_t);
extern  void ieee80211_release_node(struct ieee80211com *,
        struct ieee80211_node *);
extern  void ieee80211_free_allnodes(struct ieee80211com *);
typedef void ieee80211_iter_func(void *, struct ieee80211_node *);
extern  void ieee80211_iterate_nodes(struct ieee80211com *ic,
        ieee80211_iter_func *, void *);
extern  void ieee80211_clean_nodes(struct ieee80211com *);
extern  int ieee80211_setup_rates(struct ieee80211com *,
        struct ieee80211_node *, const u_int8_t *, const u_int8_t *, int);
extern  int ieee80211_iserp_sta(const struct ieee80211_node *);

extern  void ieee80211_node_join(struct ieee80211com *,
        struct ieee80211_node *, int);
extern  void ieee80211_node_leave(struct ieee80211com *,
        struct ieee80211_node *);
extern  int ieee80211_match_bss(struct ieee80211com *,
        struct ieee80211_node *);
extern  void ieee80211_create_ibss(struct ieee80211com* ,
        struct ieee80211_channel *);
extern  void ieee80211_notify_dtim(struct ieee80211com *);

extern  int ieee80211_node_cmp(const struct ieee80211_node *,
        const struct ieee80211_node *);


//RB_PROTOTYPE(ieee80211_tree, ieee80211_node, ni_node, ieee80211_node_cmp);

#endif /* _NET80211_IEEE80211_NODE_H_ */
